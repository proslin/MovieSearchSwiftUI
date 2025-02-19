//
//  FavouriteMovieCell.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 16.02.2025.
//

import SwiftUI

struct FavouriteMovieCell: View {
    let movie: Movie
    var body: some View {
        HStack(alignment: .top) {
            
            VStack(alignment: .leading) {
                Text("\(movie.name)")
                    .font(.title2)
                    .foregroundStyle(.primary)
                Text("\(movie.year)".replacingOccurrences(of: " ", with: ""))
                Text(!movie.alternativeName.isEmpty ? "\(movie.alternativeName), \(movie.movieLength) мин" : "\(movie.movieLength) мин")
                    .foregroundStyle(.secondary)
                
                Text(movie.getStringFromNames(movie.countries))
                    .font(.body)
                    .foregroundStyle(.secondary)
                Text(movie.getStringFromNames(movie.genres))
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .fontWeight(.medium)
                
                //            Text(movie.description)
            }
            Spacer()
            Text("\(movie.rating?.kp ?? 0.0, specifier: "%.1f")")
                .frame(width: 30, height: 30)
                .background(.green)
                .foregroundStyle(.white)
                .bold()
                
        }

    }
}

#Preview {
    FavouriteMovieCell(movie: MockData.sampleMovie)
}
