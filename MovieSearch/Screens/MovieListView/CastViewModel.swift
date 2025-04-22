//
//  CastViewModel.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 16.03.2025.
//

import Combine

final class CastViewModel: ObservableObject {
    // input
    @Published var movieID: Int = 0
    // output
    @Published var casts = [Person]()
    
    init(movieId: Int) {
        self.movieID = movieId
        $movieID
            .flatMap { (movieId) -> AnyPublisher<[Person], Never> in
                MovieAPI.shared.fetchCredits(for: movieId)
            }
            .assign(to: \.casts, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}
