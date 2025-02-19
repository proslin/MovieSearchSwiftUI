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
            
            AsyncImage(url: URL(string: movie.poster?.url ?? "")) { image in
//                AsyncImage(url: URL(string: "https://image.openmoviedb.com/kinopoisk-images/6201401/022a58e3-5b9b-411b-bfb3-09fedb700401/orig")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 120)
            } placeholder: {
                Image("placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 120)
            }
            
            VStack(alignment: .leading) {
                Text("\(movie.name)  \(Text("\(movie.year)".replacingOccurrences(of: " ", with: "")).foregroundStyle(.orange))")
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
                
                //            Text(movie.description)
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
    
//    func getStringFromNames(_ basicItemsArray: Array<BasicNameItem>) -> String {
//        var finalString: String = ""
//        for (indx, elem) in basicItemsArray.enumerated() {
//            finalString += (indx == basicItemsArray.count - 1) ? (elem.name) : elem.name + ", "
//        }
//        return finalString
//    }
}

#Preview {
    MovieListCell(movie: MockData.sampleMovie)
}
