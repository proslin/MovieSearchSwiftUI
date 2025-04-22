//
//  ImageStyle.swift
//  MovieSearch
//
//  Created by Lina Prosvetova on 21.03.2025.
//

import Foundation

import SwiftUI

struct ImageStyle: ViewModifier {
    enum Size {
        case small, medium, big, cast
        
        func width() -> CGFloat {
            switch self {
            case .small: return 53
            case .medium: return 100
            case .big: return 250
            case .cast: return 120
            }
        }
        func height() -> CGFloat {
            switch self {
            case .small: return 80
            case .medium: return 150
            case .big: return 375
            case .cast: return 180
            }
        }
    }
    
    let size: Size
    
    func body(content: Content) -> some View {
        return content
            .frame(width: size.width(), height: size.height())
            .cornerRadius(5)
            .shadow(radius: 8)
    }
}

extension View {
    func posterStyle(size: ImageStyle.Size) -> some View {
        return ModifiedContent(content: self, modifier: ImageStyle(size: size))
    }
}
