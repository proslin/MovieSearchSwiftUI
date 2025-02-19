//
//  PersonsListViewModel.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 19.01.2025.
//

//import Foundation
//
//@MainActor final class PersonsListViewModel: ObservableObject {
//   
//    @Published var persons: Array<Person> = []
//    @Published var movieId: Int
//    @Published var alertItem: AlertItem?
//    
//    init(movieId: Int, persons: Array<Person> = [], alertItem: AlertItem? = nil) {
//        self.persons = persons
//        self.movieId = movieId
//        self.alertItem = alertItem
//    }
//    
//    func getMovieWithPersons() {
//        Task {
//            do {
//               
//                persons = try await NetworkManager.shared.getMovieById(movieId).persons
//                
//            } catch {
//                if let movieError = error as? ApiError {
//                    switch movieError {
//                    case .invalidURL:
//                        self.alertItem = AlertContext.invalidURL
//                    default:
//                        self.alertItem = AlertContext.unableToComplete
//                    }
//                } else {
//                    alertItem = AlertContext.invalidResponse
//                }
//            }
//        }
//    }
//}
