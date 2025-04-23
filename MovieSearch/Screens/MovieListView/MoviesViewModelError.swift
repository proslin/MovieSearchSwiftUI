//
//  MoviesViewModelError.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 22.04.2025.
//

import Combine

final class MoviesViewModelErr: ObservableObject {
    var movieAPI = MovieAPI.shared
    // input
    @Published var indexEndpoint: Int = 0
    // output
    @Published var movies: Array<Movie> = []
    @Published var moviesError: MovieError?
    
    init() {
        $indexEndpoint
        .setFailureType(to: MovieError.self)
        .flatMap { (indexEndpoint) -> AnyPublisher<[Movie], MovieError> in
            self.movieAPI.fetchMoviesErr(from: Endpoint( index: indexEndpoint)!)
        }
        .sink(receiveCompletion:  {[unowned self] (completion) in
            if case let .failure(error) = completion {
                self.moviesError = error
            }},
              receiveValue: { [unowned self] in
                self.movies = $0
        })
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}
