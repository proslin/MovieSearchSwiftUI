//
//  FavouriteView.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 07.01.2025.
//

import SwiftUI
import SwiftData

struct FavouriteView: View {
    @Query var movies: Array<Movie>
    @State private var path = [Movie]()
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(movies) { movie in
                    NavigationLink(value: movie) {
                        VStack {
                            FavouriteMovieCell(movie: movie)
//                                                    Text(movie.name)
//                                                        .font(.headline)
//                                                    Text("\(movie.year)")
                        }
                    }
                    }
                    .onDelete(perform: deleteMovie)
                }
    
            .navigationTitle("Любимые фильмы")
            .navigationDestination(for: Movie.self, destination: EditFavouriteMovieView.init)
            .toolbar {
                Button("Добавить фильм", systemImage: "plus", action: addMoview)
            }
        }
    }
    
    func deleteMovie(_ indexSet: IndexSet) {
        for index in indexSet {
            let movie = movies[index]
            modelContext.delete(movie)
        }
    }
    
    func addMoview() {
        let movie = Movie(id: Int.random(in: 1..<100000), name: "", alternativeName: "", enName: "", year: 0, fullDescription: "", movieLength: 0, countries: [])
        modelContext.insert(movie)
        path = [movie]
    }
    
    func addSamples() {
        let sampleMovie1 = Movie(id: 001,
                                       name: "Один дома",
                                       alternativeName: "Home alone",
                                       enName: "Home alone",
                                       year: 1995,
                                       fullDescription: "Американское семейство отправляется из Чикаго в Европу, но в спешке сборов бестолковые родители забывают дома... одного из своих детей. Юное создание, однако, не теряется и демонстрирует чудеса изобретательности. И когда в дом залезают грабители, им приходится не раз пожалеть о встрече с милым крошкой.",
                                       movieLength: 120,
                                poster: nil,
                                       genres: [BasicNameItem(name: "комедия"), BasicNameItem(name: "приключения")],
                                       countries: [BasicNameItem(name: "США")],
                                       rating: RatingModel(kp: 8.277, imdb: 7.7))
        let sampleMovie2 = Movie(id: 002,
                                       name: "Один дома 2",
                                       alternativeName: "Home alone",
                                       enName: "Home alone",
                                       year: 1999,
                                       fullDescription: "Американское семейство отправляется из Чикаго в Европу, но в спешке сборов бестолковые родители забывают дома... одного из своих детей. Юное создание, однако, не теряется и демонстрирует чудеса изобретательности. И когда в дом залезают грабители, им приходится не раз пожалеть о встрече с милым крошкой.",
                                       movieLength: 120,
                                poster: nil,
                                       genres: [BasicNameItem(name: "комедия"), BasicNameItem(name: "приключения")],
                                       countries: [BasicNameItem(name: "США")],
                                       rating: RatingModel(kp: 8.277, imdb: 7.7))
        modelContext.insert(sampleMovie1)
        modelContext.insert(sampleMovie2)
    }
}

#Preview {
    FavouriteView()
}
