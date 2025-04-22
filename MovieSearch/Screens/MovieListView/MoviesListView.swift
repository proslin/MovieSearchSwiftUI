//
//  MoviesListView.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 01.03.2025.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var moviesViewModel = MoviesViewModel()
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
            .navigationBarTitle("Movies")
        } // Navigation
    } // body
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
