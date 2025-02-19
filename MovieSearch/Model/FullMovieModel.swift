//
//  FullMovieModel.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 25.01.2025.
//

import Foundation

struct FullMovieModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let alternativeName: String
    let enName: String
    let year: Int
    let description: String
    let movieLength: Int
//    let poster: ImageURLs
    let genres: Array<BasicNameItem>
    let countries: Array<BasicNameItem>
    let rating: RatingModel
//    var persons: Array<Person> = []
    
    func getStringFromNames(_ basicItemsArray: Array<BasicNameItem>) -> String {
        var finalString: String = ""
        for (indx, elem) in basicItemsArray.enumerated() {
            finalString += (indx == basicItemsArray.count - 1) ? (elem.name) : elem.name + ", "
        }
        return finalString
    }
}

//struct ImageURLs: Decodable {
//    let url: String
////    let previewUrl: String
//}
//
//struct MovieResponse: Decodable {
//    let docs: Array<Movie>
//}
//
//struct BasicNameItem: Decodable {
//    let name: String
//}
//
//struct RatingModel: Decodable {
//    let kp: Double
//    let imdb: Double
//}
