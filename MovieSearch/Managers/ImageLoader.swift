//
//  ImageLoader.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 18.03.2025.
//

import UIKit
import Combine


class ImageLoaderCache {
    static let shared = ImageLoaderCache()
    var loaders: NSCache<NSString, ImageLoader> = NSCache()
    
    func loaderFor(movie: Movie) -> ImageLoader {
        let key = NSString(string: "\(movie.id)")
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            guard let posterUrl = movie.poster?.url,
                  !posterUrl.isEmpty,
                  posterUrl != "nul",
                  let path = URL(string: posterUrl) else { return ImageLoader (url: nil)}
            let loader = ImageLoader(url: path)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
    
    func loaderFor(cast: Person) -> ImageLoader {
        let key = NSString(string: "\(cast.id)")
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            guard let path = cast.photo,
            let pathURL = URL(string: path) else {
                return ImageLoader (url: nil)
            }
            let loader = ImageLoader(url: pathURL)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
}

final class ImageLoader: ObservableObject {
    // input
    @Published var url: URL?
    // output
    @Published var image: UIImage?
    
    init(url: URL?) {
        self.url = url
        $url
            .flatMap { (path) -> AnyPublisher<UIImage?, Never> in
               self.fetchImage(for: url)
            }
            .assign(to: \.image, on: self)
            .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []
    
    private func fetchImage(for url: URL?)
                            -> AnyPublisher <UIImage?, Never> {
        guard url != nil, image == nil else {
            return Just(nil).eraseToAnyPublisher()             // 1
        }
        return
            URLSession.shared.dataTaskPublisher(for: url!)     // 2
                .map { UIImage(data: $0.data) }                // 3
                .replaceError(with: nil)                       // 4
                .receive(on: RunLoop.main)                     // 5
                .eraseToAnyPublisher()                         // 6
    }
    
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}
