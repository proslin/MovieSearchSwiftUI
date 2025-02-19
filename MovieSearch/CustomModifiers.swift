//
//  CustomModifiers.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 11.01.2025.
//

import SwiftUI

struct StandardButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .background(in: .capsule, fillStyle: .init())
            .tint(.secondary)
            .controlSize(.large)
    }
}

extension View {
    func standardButtonStyle() -> some View {
        self.modifier(StandardButtonStyle())
    }
}
