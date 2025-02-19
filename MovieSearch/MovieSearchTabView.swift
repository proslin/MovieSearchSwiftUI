//
//  ContentView.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 07.01.2025.
//

import SwiftUI

struct MovieSearchTabView: View {
    var body: some View {
        TabView {
            Tab("Поиск", systemImage: "magnifyingglass.circle.fill") {
                SearchView()
            }
            Tab("Любимые", systemImage: "star.circle.fill") {
                FavouriteView()
            }
                
        }
    }
}

#Preview {
    MovieSearchTabView()
}
