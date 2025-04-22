//
//  EditFavouriteMovieView.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 15.02.2025.
//

import SwiftUI
import SwiftData

struct EditFavouriteMovieView: View {
    @Bindable var movie: Movie
    var body: some View {
        Form {
            TextField("Название", text: $movie.name)
            TextField("Альтернативное название", text: $movie.alternativeName)
            TextField("Год", value: $movie.year, formatter: NumberFormatter())

        }
        .navigationTitle("Редактируем информацию о фильме")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Movie.self, configurations: config)

        let example = Movie(id: 005, name: "Jl by ljvf 3", alternativeName: "", enName: "", year: 1990, fullDescription: "", movieLength: 120, poster: nil, genres: [], countries: [], rating: nil)
            return EditFavouriteMovieView(movie: example)
                .modelContainer(container)
        } catch {
            fatalError("Failed to create model container.")
        }
}
