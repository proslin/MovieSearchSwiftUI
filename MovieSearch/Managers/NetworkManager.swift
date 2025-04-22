//
//  NetworkManager.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 07.01.2025.
//

import Foundation
import Combine
import UIKit
import SwiftUI

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.kinopoisk.dev/v1.4/movie/"
    private let searchURL = "search?page=1&limit=20&query="
    private let searchByID = ""
    private let cache = NSCache<NSString, UIImage>()
    private init() {}
    
    func getMovies(searchString: String) async throws -> [Movie] {
        let fullURL = baseURL + searchURL + searchString
        guard let url = URL(string: fullURL) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("8END4KV-EQ54NV1-KK714FW-MPF1JJQ", forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let (data, respone) = try await URLSession.shared.data(for: request)
        print(respone)
        
        let object = try JSONSerialization.jsonObject(with: data)
        let prettyPrintedData = try JSONSerialization.data(
            withJSONObject: object,
            options: [.prettyPrinted, .sortedKeys]
        )
        let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8)!
        print(prettyPrintedString)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(MovieResponse.self, from: data).docs
        } catch {
            throw ApiError.invalidData
        }
    }
    
    func getMovieById(_ id: Int) async throws -> MovieModelByID {
        let fullURL = baseURL + String(id)
        guard let url = URL(string: fullURL) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("8END4KV-EQ54NV1-KK714FW-MPF1JJQ", forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let object = try JSONSerialization.jsonObject(with: data)
        let prettyPrintedData = try JSONSerialization.data(
            withJSONObject: object,
            options: [.prettyPrinted, .sortedKeys]
        )
        let prettyPrintedString = String(data: prettyPrintedData, encoding: .utf8)!
        print(prettyPrintedString)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(MovieModelByID.self, from: data)
        } catch {
            throw ApiError.invalidData
        }
    }
    
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }

}
