//
//  MovieRemoteImage.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 21.03.2025.
//

import SwiftUI

struct MovieRemoteImage: View {
    @ObservedObject var imageLoader: ImageLoader
    @State private var animate = false
    let posterSize: ImageStyle.Size
    
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .renderingMode(.original)
                    .posterStyle(size: posterSize)
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                    .posterStyle( size: posterSize)
                    .overlay(
                        Text(imageLoader.url != nil ? "Loading..." : "")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .rotationEffect(Angle(degrees: animate ? 60 : -60))
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                                    self.animate = true
                                }
                        }
                    )
            }
        }
    }
}

struct MoviePosterImage_Previews: PreviewProvider {
    static var previews: some View {
        MovieRemoteImage(imageLoader: ImageLoader (url: URL(string: "https://image.tmdb.org/t/p/w500//pThyQovXQrw2m0s9x82twj48Jq4.jpg")), posterSize: ImageStyle.Size.big)
      
    }
}
