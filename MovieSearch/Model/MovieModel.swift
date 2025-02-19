//
//  MovieModel.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 07.01.2025.
//

import Foundation
import SwiftData

@Model
class Movie: Codable, Identifiable {
    @Attribute(.unique) var id: Int
    var name: String = ""
    var alternativeName: String = ""
    var enName: String = ""
    var year: Int = 0
    var fullDescription: String = ""
    var movieLength: Int = 0
    var poster: ImageURLs?
    var genres: Array<BasicNameItem> = []
    var countries: Array<BasicNameItem> = []
    var rating: RatingModel?
    @Relationship(deleteRule: .cascade) var persons = [Person]()
//    var persons: Array<Person>? = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case alternativeName
        case enName
        case year
        case fullDescription = "description"
        case movieLength
        case poster
        case genres
        case countries
        case rating
        case persons
    }
    
    init(id: Int, name: String, alternativeName: String, enName: String, year: Int, fullDescription: String, movieLength: Int, poster: ImageURLs? = nil, genres: Array<BasicNameItem> = [], countries: Array<BasicNameItem>, rating: RatingModel? = nil, persons: Array<Person> = []) {
        self.id = id
        self.name = name
        self.alternativeName = alternativeName
        self.enName = enName
        self.year = year
        self.fullDescription = fullDescription
        self.movieLength = movieLength
        self.poster = poster
        self.genres = genres
        self.countries = countries
        self.rating = rating
        self.persons = persons
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        alternativeName = try values.decode(String.self, forKey: .alternativeName)
        enName = try values.decode(String.self, forKey: .enName)
        year = try values.decode(Int.self, forKey: .year)
        fullDescription = try values.decode(String.self, forKey: .fullDescription)
        movieLength = try values.decode(Int.self, forKey: .movieLength)
        poster = try values.decode(ImageURLs.self, forKey: .poster)
        genres = try values.decode(Array<BasicNameItem>.self, forKey: .genres)
        countries = try values.decode(Array<BasicNameItem>.self, forKey: .countries)
        rating = try values.decode(RatingModel.self, forKey: .rating)
//        persons = try values.decode(Array<Person>.self, forKey: .persons)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(alternativeName, forKey: .alternativeName)
        try container.encode(enName, forKey: .enName)
        try container.encode(year, forKey: .year)
        try container.encode(fullDescription, forKey: .fullDescription)
        try container.encode(movieLength, forKey: .movieLength)
        try container.encode(poster, forKey: .poster)
        try container.encode(genres, forKey: .genres)
        try container.encode(countries, forKey: .countries)
        try container.encode(rating, forKey: .rating)
//        try container.encode(persons, forKey: .persons)
    }
    
    func getStringFromNames(_ basicItemsArray: Array<BasicNameItem>) -> String {
        var finalString: String = ""
        for (indx, elem) in basicItemsArray.enumerated() {
            finalString += (indx == basicItemsArray.count - 1) ? (elem.name) : elem.name + ", "
        }
        return finalString
    }
}

struct ImageURLs: Codable {
    let url: String?
    let previewUrl: String?
    
    enum posterCodingKeys: String, CodingKey {
            case url
            case previewUrl = "previewUrl"
        }
}

struct MovieResponse: Codable {
    let docs: Array<Movie>
}

struct BasicNameItem: Codable {
    let name: String
}

struct RatingModel: Codable {
    let kp: Double
    let imdb: Double
}
