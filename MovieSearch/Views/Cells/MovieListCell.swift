//
//  MovieListCell.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 07.01.2025.
//

import SwiftUI

struct MovieListCell: View {
    
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top) {
            MovieRemoteImage(imageLoader: ImageLoaderCache.shared.loaderFor(movie: movie), posterSize: .medium)
            
            VStack(alignment: .leading) {
                Text("\(!movie.name.isEmpty ? movie.name : movie.alternativeName)  \(Text("\(movie.year)".replacingOccurrences(of: " ", with: "")).foregroundStyle(.orange))")
                    .font(.title2)
                    .foregroundStyle(.primary)
                Text(!movie.alternativeName.isEmpty ? "\(movie.alternativeName), \(movie.movieLength) мин" : "\(movie.movieLength) мин")
                    .foregroundStyle(.secondary)
                
                Text(movie.getStringFromNames(movie.countries))
                    .font(.body)
                    .foregroundStyle(.secondary)
                Text(movie.getStringFromNames(movie.genres))
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .fontWeight(.medium)
            }
            Spacer()
            Text("\(movie.rating?.kp ?? 0.0, specifier: "%.1f")")
                .frame(width: 30, height: 30)
                .background(getRateColor())
                .foregroundStyle(.white)
                .bold()
                
        }

    }
    
    func getRateColor() -> Color {
        if let kpRate = movie.rating?.kp {
            if kpRate > 6.0 {
                return .green
            } else if kpRate > 3.0 {
                return .gray
            } else {
                return .red
            }
        }
        return .red
    }
}

#Preview {
    MovieListCell(movie: MockData.sampleMovie)
}
