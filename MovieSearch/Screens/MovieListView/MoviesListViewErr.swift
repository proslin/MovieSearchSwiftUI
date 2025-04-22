//
//  MoviesListViewErr.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 22.04.2025.
//

import SwiftUI

struct MoviesListViewErr: View {
    @ObservedObject var moviesViewModel = MoviesViewModelErr()
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $moviesViewModel.indexEndpoint){
                    Text("Фильмы").tag(0)
                    Text("Сериалы").tag(1)
                    Text("Мультики").tag(2)
                    Text("Аниме").tag(3)
                    Text("Мульт сериалы").tag(4)
                }
                .pickerStyle(SegmentedPickerStyle())
                List(moviesViewModel.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieListCell(movie: movie)
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("Список фильмов")
            }
            .alert(item: self.$moviesViewModel.moviesError) { error in
                Alert(
                    title: Text("Network error"),
                    message: Text(error.localizedDescription).font(.subheadline),
                    dismissButton: .default(Text("OK"))
                )
            } // alert
            .navigationBarTitle("Movies")
        } // Navigation
    } // body
}

struct MoviesListViewErr_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListViewErr()
    }
}
