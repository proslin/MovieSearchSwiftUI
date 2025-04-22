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

struct PressedButtonStyle: ButtonStyle {
    let color: Color
    let pressedColor: Color

    func makeBody(configuration: Configuration) -> some View {
           configuration.label
               .padding()
               .background(configuration.isPressed ? pressedColor : color)
               .foregroundColor(.white)
               .clipShape(RoundedRectangle(cornerRadius: 10))
               .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
               .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
       }
}
