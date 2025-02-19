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
//                    .textFieldStyle(.roundedBorder)
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
                    
                    //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: performSearch) {
                        Image(systemName: "magnifyingglass")
                    }
                    .foregroundStyle(.secondary)
                }
                .padding()
                
                //                        .onAppear(perform: {
                //                            UITextField.appearance().clearButtonMode = .whileEditing
                //                        })
                //                    HStack {
                //                        TextField("", text: $searchText)
                //                            if !searchText.isEmpty {
                //                                Button {
                //                                    searchText = ""
                //                                    viewModel.getMovies(searchString: searchText)
                //                                }label: {
                //                                    Image(systemName: "multiply.circle.fill")
                //                                }
                //                                .padding(.trailing, 10)
                //                            }
                //                    }
                //                    .border(.blue)
                
                //                }   .padding()
                //                SearchBar(searchString: viewModel.searchTerm)
                //                Text("Searching for \(searchText)")
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
            //            .searchable(text: $searchText)
            //            .task {
            //                viewModel.getMovies(searchString: searchText)
            //            }
            
            
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



//VStack {
//                    SearchBar(text: $viewModel.searchTerm,
//                              onSearchButtonClicked: viewModel.onSearchTapped)
//                    List(viewModel.games, id: \.title) { game in
//                        Text(verbatim: game.title)
//                    }
//                }



#Preview {
    SearchView()
}

//struct SearchBar: View {
//
//    @State var searchString: String = ""
//
//    var body: some View {
//
//        HStack {
//            TextField(
//                "Start typing",
//                text: $searchString,
//                onCommit: performSearch)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            Button(action: performSearch) {
//                Image(systemName: "magnifyingglass")
//            }
//        }   .padding()
//    }
//
//    func performSearch() {
//        viewModel.getMovies(searchString: $searchString)
//    }
//}
