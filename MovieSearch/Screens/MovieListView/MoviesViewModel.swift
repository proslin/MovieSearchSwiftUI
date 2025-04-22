//
//  MoviesViewModel.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 01.03.2025.
//

import Foundation
import Combine

final class MoviesViewModel: ObservableObject {
    // input
    @Published var indexEndpoint: Int = 0
    // output
    @Published var movies: Array<Movie> = []
    @Published var isLoading = false
    @Published var canLoadMore = true
    
    private var currentPage = 0
        private let pageSize = 20
    
    init() {
          $indexEndpoint
           .flatMap { (indexEndpoint) -> AnyPublisher<[Movie], Never> in
                MovieAPI.shared.fetchMovies(from:
                                    Endpoint( index: indexEndpoint)!)
           }
         .assign(to: \.movies, on: self)
         .store(in: &self.cancellableSet)
   }
    
    private var cancellableSet: Set<AnyCancellable> = []
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}
