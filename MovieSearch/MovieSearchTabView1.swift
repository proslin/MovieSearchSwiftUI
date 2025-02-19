//
//  MovieSearchTabView.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 07.01.2025.
//

import SwiftUI

struct MovieSearchTabView1: View {
    var body: some View {
        TabView {
            Tab("Поиск", systemImage: "search") {
                SearchView()
            }
            Tab("Любимые", systemImage: "search") {
                FavouriteView()
            }
                
        }
    }
}

#Preview {
    MovieSearchTabView1()
}
