//
//  MovieAPI.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 01.03.2025.
//

import UIKit
import Combine

enum Endpoint {
    case search (searchString: String)
    case credits (movieId: Int)
    case movie, tvSeries, cartoon, anime, animatedSeries
    
    var baseURL: URL {
        URL(string: "https://api.kinopoisk.dev/v1.4/movie")!
    }
    
    init? (index: Int) {
        switch index {
        case 0: self = .movie
        case 1: self = .tvSeries
        case 2: self = .cartoon
        case 3: self = .anime
        case 4: self = .animatedSeries
        default: return nil
        }
    }
    
    func path() -> String {
        switch self {
        case .movie, .tvSeries, .cartoon, .anime, .animatedSeries:
            return ""
        case .search (_):
            return "/search"
        case .credits(let movieId):
            return "/\(movieId)"
        }
    }
    
    var absoluteURL: URL? {
        let queryURL = baseURL.appending(path: self.path())
        let components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else {
            return nil
        }
        urlComponents.queryItems = [URLQueryItem(name: "page", value: "2"),
                                    URLQueryItem(name: "limit", value: "20"),
                                    URLQueryItem(name: "notNullFields", value: "description"),
                                    URLQueryItem(name: "sortField", value: "rating.kp"),
                                    URLQueryItem(name: "sortType", value: "-1")
        ]
        
        switch self {
        case .search(let name):
            urlComponents.queryItems = [URLQueryItem(name: "query", value: name),
                                        URLQueryItem(name: "page", value: "1"),
                                        URLQueryItem(name: "limit", value: "20")
            ]
        case .movie:
            urlComponents.queryItems?.append(URLQueryItem(name: "type", value: "movie"))
        case .tvSeries:
            urlComponents.queryItems?.append(URLQueryItem(name: "type", value: "tv-series"))
        case .cartoon:
            urlComponents.queryItems?.append(URLQueryItem(name: "type", value: "cartoon"))
        case .anime:
            urlComponents.queryItems?.append(URLQueryItem(name: "type", value: "anime"))
        case .animatedSeries:
            urlComponents.queryItems?.append(URLQueryItem(name: "type", value: "animated-series"))
        case .credits( _ ):
            return queryURL
        }
        return urlComponents.url
    }
}

struct APIConstants {
    static let apiKey: String = "8END4KV-EQ54NV1-KK714FW-MPF1JJQ"
    
    static let jsonDecoder: JSONDecoder = {
           let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
           let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-mm-dd"
               jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
            return jsonDecoder
          }()
}

class MovieAPI {
    public static let shared = MovieAPI()
    
    private var subscriptions = Set<AnyCancellable>()
    
    deinit {
        for cancell in subscriptions {
            cancell.cancel()
        }
    }
    
    // асинхронная выборка на основе URL
    func fetch<T: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map{$0.data}
            .decode(type: T.self, decoder: APIConstants.jsonDecoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    // выборка фильмов
    func fetchMovies(from endpoint: Endpoint) -> AnyPublisher<[Movie], Never> {
        guard let url = endpoint.absoluteURL else {
            return Just([Movie]()).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.setValue(APIConstants.apiKey, forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        return fetch(request)
            .map{ (response: MovieResponse) -> [Movie] in
                response.docs
            }
            .replaceError(with: [Movie]())
            .eraseToAnyPublisher()
    }
    
    // выборка актерского состава
    func fetchCredits(for movieId: Int) -> AnyPublisher<[Person], Never> {
        guard let url = Endpoint.credits(movieId: movieId).absoluteURL else {
            return Just([Person]()).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.setValue(APIConstants.apiKey, forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        return fetch(request)
            .map{ (response: MovieModelByID) -> [Person] in
                response.persons
            }
            .replaceError(with: [Person]())
            .eraseToAnyPublisher()
    }
    
    func fetchMoviesErr1(from endpoint: Endpoint) ->
    AnyPublisher<[Movie], MovieError>{
        return Future<[Movie], MovieError> { [unowned self] promise in
            guard let url = endpoint.absoluteURL  else {
                return promise(.failure(.urlError(                          // 0
                    URLError(.unsupportedURL))))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)                  // 1
                .tryMap { (data, response) -> Data in                       // 2
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        throw MovieError.responseError(
                            ((response as? HTTPURLResponse)?.statusCode ?? 500,
                             String(data: data, encoding: .utf8) ?? ""))
                    }
                    return data
                }
                .decode(type: MovieResponse.self,
                        decoder: APIConstants.jsonDecoder) // 3
                .receive(on: RunLoop.main)                                       // 4
                .sink(
                    receiveCompletion: { (completion) in                          // 5
                        if case let .failure(error) = completion {
                            switch error {
                            case let urlError as URLError:
                                promise(.failure(.urlError(urlError)))
                            case let decodingError as DecodingError:
                                promise(.failure(.decodingError(decodingError)))
                            case let apiError as MovieError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(.genericError))
                            }
                        }
                    },
                    receiveValue: { promise(.success($0.docs)) })             // 6
                .store(in: &self.subscriptions)                                // 7
        }
        .eraseToAnyPublisher()                                              // 8
    }
    
    // Выборка коллекции фильмов с сообщением об ошибке
        func fetchMoviesErr(from endpoint: Endpoint) ->
    AnyPublisher<[Movie], MovieError>{
        Future<[Movie], MovieError> { [unowned self] promise in
            guard let url = endpoint.absoluteURL  else {
                return promise(
                    .failure(.urlError(URLError(.unsupportedURL))))
            }
            
            var request = URLRequest(url: url)
            request.setValue(APIConstants.apiKey, forHTTPHeaderField: "X-API-KEY")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            
            self.fetch(request)
                .tryMap { (result: MovieResponse) -> [Movie] in
                    result.docs }
                .sink(
                    receiveCompletion: { (completion) in
                        if case let .failure(error) = completion {
                            switch error {
                            case let urlError as URLError:
                                promise(.failure(.urlError(urlError)))
                            case let decodingError as DecodingError:
                                promise(.failure(.decodingError(decodingError)))
                            case let apiError as MovieError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(.genericError))
                            }
                        }
                    },
                    receiveValue: { promise(.success($0)) })                     // 4
                .store(in: &self.subscriptions)                                 // 5
        }
        .eraseToAnyPublisher()
    }
}
