//
//  ApiError.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 08.01.2025.
//

import Foundation

enum ApiError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
    case emptyName
    case invalidEmail
}
