//
//  SearchView.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 07.01.2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            NavigationStack {
                HStack {
                    TextField(
                        " Кино, сериалы",
                        text: $searchText,
                        onCommit: performSearch)
                    .frame(height: 50)
                    .background(.white)
                    .foregroundStyle(.black)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                            viewModel.getMovies(searchString: searchText)
                        }label: {
                            Image(systemName: "multiply.circle.fill")
                            
                        }
                        .foregroundStyle(.secondary)
                        .padding(.trailing, 10)
                    }
                    Button(action: performSearch) {
                        Image(systemName: "magnifyingglass")
                    }
                    .foregroundStyle(.secondary)
                }
                .padding()

                List(viewModel.movies) { movie in
                    MovieListCell(movie: movie)
                        .onTapGesture {
                            viewModel.selectedMovie = movie
                            viewModel.getMovieWithPersons()
                        }
                }
                .listStyle(.plain)
                .sheet(item: $viewModel.selectedMovie) { movie in
                    MovieDetailView(movie: movie)
                }
                .navigationTitle("Список фильмов")
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
    
    func performSearch() {
        viewModel.getMovies(searchString: searchText)
    }
}

#Preview {
    SearchView()
}
