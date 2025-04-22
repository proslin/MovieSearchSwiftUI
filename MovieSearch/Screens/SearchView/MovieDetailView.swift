//
//  MovieDetailView.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 11.01.2025.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: movie.poster?.url ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 300)
                        .padding()
                } placeholder: {
                    Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 300)
                    .padding()
                }

                Text("\(!movie.name.isEmpty ? movie.name : movie.alternativeName) \(Text("\(movie.year)".replacingOccurrences(of: " ", with: "")))")
                    .font(.title)
                    .padding(.bottom)

                Button("+ Буду смотреть") {
                    addMovie()
                }
                .buttonStyle(PressedButtonStyle(color: .green, pressedColor: .orange))
                
                Text("O фильме")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                VStack {
                    InfoItemView(name: "Год производства", value: "\(movie.year)")
                    InfoItemView(name: "Страна", value: movie.getStringFromNames(movie.countries))
                    InfoItemView(name: "Жанр", value: movie.getStringFromNames(movie.genres))
                    InfoItemView(name: "Время", value: "\(movie.movieLength) мин")
                    InfoItemView(name: "Оригинальное название", value: "\(movie.alternativeName)")
                }
                .padding(.bottom)
                Text(movie.fullDescription)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
                HStack {
                    Text("Рейтинг фильма")
                    Spacer()
                    Text("\(movie.rating?.kp ?? 0.0, specifier: "%.1f")")
                        .font(.title2)
                        .foregroundStyle(.orange)
                }
                PersonsListView(castsViewModel: CastViewModel(movieId: movie.id))
            }
        }
        .overlay(Button {
            dismiss()
        } label: {
            XDismissButton()
        }, alignment: .topTrailing)
        .padding()
    }
    
    func addMovie() {
        modelContext.insert(movie)
    }
}


#Preview {
    MovieDetailView(movie: MockData.sampleMovie)
}

struct InfoItemView: View {
    let name: String
    let value: String
    
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(value)
            
        }
        .foregroundStyle(.secondary)
    }
}
