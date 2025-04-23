//
//  MovieModelByID.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 19.01.2025.
//

import Foundation
import SwiftData

struct MovieModelByID: Decodable, Identifiable {
    let id: Int
    var persons: Array<Person> = []
}

@Model
class Person: Codable, Identifiable {
    @Attribute(.unique) var id: Int
    var name: String = ""
    var photo: String?
    var enName: String?
    var character: String?
    var profession: String = ""
    var enProfession: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo
        case enName
        case character = "description"
        case profession
        case enProfession
    }
    
    init(id: Int, name: String = "", photo: String? = nil, enName: String? = nil, character: String? = nil, profession: String = "", enProfession: String = "") {
        self.id = id
        self.name = name
        self.photo = photo
        self.enName = enName
        self.character = character
        self.profession = profession
        self.enProfession = enProfession
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        if let name = try values.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        } else {
            self.name = ""
        }

        if let photo = try values.decodeIfPresent(String.self, forKey: .photo) {
            self.photo = photo
        } else {
            self.photo = ""
        }

        if let enName = try values.decodeIfPresent(String.self, forKey: .enName) {
            self.enName = enName
        } else {
            self.enName = ""
        }

        if let character = try values.decodeIfPresent(String.self, forKey: .character) {
            self.character = character
        } else {
            self.character = ""
        }

        if let profession = try values.decodeIfPresent(String.self, forKey: .profession) {
            self.profession = profession
        } else {
            self.profession = ""
        }

        if let enProfession = try values.decodeIfPresent(String.self, forKey: .enProfession) {
            self.enProfession = enProfession
        } else {
            self.enProfession = ""
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(photo, forKey: .photo)
        try container.encode(enName, forKey: .enName)
        try container.encode(character, forKey: .character)
        try container.encode(profession, forKey: .profession)
        try container.encode(enProfession, forKey: .enProfession)
    }
}
