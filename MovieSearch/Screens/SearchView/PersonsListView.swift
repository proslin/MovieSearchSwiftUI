//
//  PersonsListView.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 19.01.2025.
//

import SwiftUI

struct PersonsListView: View {
    let persons: Array<Person>
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack (spacing: 15) {
                ForEach(persons) { person in
                    VStack {
                        AsyncImage(url: URL(string: person.photo ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 120)
                                .padding()
                        } placeholder: {
                            Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 120)
                            .padding()
                        }
                        Text(person.name)
                        Text(person.enName ?? "")
                        Text(person.character ?? "")
                    }
                }
            }
        }
    }
}

#Preview {
    PersonsListView(persons: MockData.personsSampleList)
}
