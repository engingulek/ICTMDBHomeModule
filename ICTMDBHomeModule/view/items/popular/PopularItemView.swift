//
//  SwiftUIView.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import Kingfisher
import ICTMDBViewKit

struct PopularItemView: View {
    let item: PopularTVShowPresentation
    
    var body: some View {
        ZStack {
            AppImage(
                source: .remote(
                    url: item.backdropPoster,
                    type: .backgroundBlur))
            HStack(alignment: .top, spacing: 12) {
                ZStack(alignment: .topTrailing) {
                    AppImage(
                        source: .remote(url: item.mainPoster, type: .main))
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size / 3
                    }
                    AppText(text: item.flag, style: .cardSubTitle)
                        .padding([.top, .trailing], 5)
                }
                .padding(.vertical, 10)
                .padding(.leading, 10)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .top) {
                        AppText(text: item.title, style: .heroTitle)
                            .padding([.top, .trailing], 5)
                        Spacer()
                        RatingView(score: item.rating, type: .popular)
                    }
                    AppText(
                        text: item.year,
                        style: .cardTitle,
                        color: .white)
                    AppText(
                        text: item.info,
                        style: .detailInfo)
                    .padding(.top, 4)
                }.padding(.top,5)
                    .padding(.trailing,5)
            }
        }
        .containerRelativeFrame(.horizontal) { size, axis in
            size - 30
        }
        .cornerRadius(10)
        .clipped()
    }
}
