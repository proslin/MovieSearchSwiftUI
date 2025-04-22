//
//  PersonsListView.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 19.01.2025.
//

import SwiftUI

struct PersonsListView: View {
    @ObservedObject var castsViewModel: CastViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack (spacing: 15) {
                ForEach (castsViewModel.casts) { person in
                    VStack {
                        MovieRemoteImage(imageLoader: ImageLoaderCache.shared.loaderFor(cast: person), posterSize: .medium)
                        Text(person.name)
                        Text(person.enName ?? "")
                        Text(person.character ?? "")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}
