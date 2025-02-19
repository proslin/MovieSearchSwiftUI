//
//  SearchListViewModel.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 08.01.2025.
//

import Foundation

@MainActor final class SearchListViewModel: ObservableObject {
    @Published var movies: Array<Movie> = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var selectedMovie: Movie?
    
    func getMovies(searchString: String) {
        isLoading = true
        Task {
            do {
                movies = try await NetworkManager.shared.getMovies(searchString: searchString)
                isLoading = false
            } catch {
                if let movieError = error as? ApiError {
                    switch movieError {
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    default:
                        self.alertItem = AlertContext.unableToComplete
                    }
                } else {
                    alertItem = AlertContext.invalidResponse
                }
                isLoading = false
            }
        }
    }
    
    func getMovieWithPersons() {
        Task {
            do {
                guard let movieId = selectedMovie?.id else { return }
                selectedMovie?.persons = try await NetworkManager.shared.getMovieById(movieId).persons.filter { $0.enProfession == "actor" }
                
            } catch {
                if let movieError = error as? ApiError {
                    switch movieError {
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    default:
                        self.alertItem = AlertContext.unableToComplete
                    }
                } else {
                    alertItem = AlertContext.invalidResponse
                }
            }
        }
    }
}
