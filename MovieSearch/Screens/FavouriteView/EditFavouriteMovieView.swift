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
            TextField("Name", text: $movie.name)
            TextField("AlternativeName", text: $movie.alternativeName)
            TextField("Year", value: $movie.year, formatter: NumberFormatter())

//            Section("Priority") {
//                Picker("Priority", selection: $destination.priority) {
//                    Text("Meh").tag(1)
//                    Text("Maybe").tag(2)
//                    Text("Must").tag(3)
//                }
//                .pickerStyle(.segmented)
//            }
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
