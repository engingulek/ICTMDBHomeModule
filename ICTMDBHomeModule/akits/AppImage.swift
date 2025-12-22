//
//  AppImage.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI

enum ImageViewType {
    case background
    case main
}


struct AppImageView: View {
    let name: String
    let type: ImageViewType
    
    var body: some View {
        Image(name)
            .resizable()
            .modifier(ImageViewStyle(type: type))
    }
}


struct ImageViewStyle: ViewModifier {
    let type: ImageViewType
    
    func body(content: Content) -> some View {
        switch type {
        case .background:
            content
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        case .main:
            content
                .aspectRatio(contentMode: .fill) // Veya .fit
                .frame(maxWidth: .infinity)
                .cornerRadius(8)
        }
    }
}
