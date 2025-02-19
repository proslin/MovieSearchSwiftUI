//
//  MovieSearchApp.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 07.01.2025.
//

import SwiftUI
import SwiftData

@main
struct MovieSearchApp: App {
    var body: some Scene {
        WindowGroup {
            MovieSearchTabView()
        }
        .modelContainer(for: [Movie.self, Person.self])
    }
}
