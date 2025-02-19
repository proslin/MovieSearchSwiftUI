//
//  MockData.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 19.01.2025.
//

import Foundation

struct MockData {
    static let sampleImage = ImageURLs(url: "https://image.openmoviedb.com/kinopoisk-images/6201401/022a58e3-5b9b-411b-bfb3-09fedb700401/orig",
                                previewUrl: "https://image.openmoviedb.com/kinopoisk-images/6201401/022a58e3-5b9b-411b-bfb3-09fedb700401/x1000")
    static let sampleMovie = Movie(id: 001,
                                   name: "Один дома",
                                   alternativeName: "Home alone",
                                   enName: "Home alone",
                                   year: 1995,
                                   fullDescription: "Американское семейство отправляется из Чикаго в Европу, но в спешке сборов бестолковые родители забывают дома... одного из своих детей. Юное создание, однако, не теряется и демонстрирует чудеса изобретательности. И когда в дом залезают грабители, им приходится не раз пожалеть о встрече с милым крошкой.",
                                   movieLength: 120,
                                   poster: sampleImage,
                                   genres: [BasicNameItem(name: "комедия"), BasicNameItem(name: "приключения")],
                                   countries: [BasicNameItem(name: "США")],
                                   rating: RatingModel(kp: 8.277, imdb: 7.7))
//                                   persons: personsSampleList)
    static let movieSampleList = [sampleMovie, sampleMovie, sampleMovie]
    
    static let samplePerson = Person(id: 002,
                                     name: "Мартин Фриман",
                                     photo: "https://image.openmoviedb.com/kinopoisk-st-images//actor_iphone/iphone360_116162.jpg",
                                     enName: "Martin Freeman",
                                     character: "Bilbo",
                                     profession: "актеры",
                                     enProfession: "actor")
    static let personsSampleList = [samplePerson, samplePerson, samplePerson]
}
