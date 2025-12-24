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
    let popular: PopularTVShowPresentation
    
    var body: some View {
        ZStack {
            AppImage(
                source: .remote(
                    url: popular.backdropPoster,
                    type: .backgroundBlur))
            HStack(alignment: .top, spacing: 12) {
                ZStack(alignment: .topTrailing) {
                    AppImage(
                        source: .remote(url: popular.mainPoster, type: .main))
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size / 3
                    }
                    AppText(text: popular.flag, style: .cardSubTitle)
                        .padding([.top, .trailing], 5)
                }
                .padding(.vertical, 10)
                .padding(.leading, 10)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .top) {
                        AppText(text: popular.title, style: .heroTitle)
                            .padding([.top, .trailing], 5)
                        Spacer()
                        RatingView(score: popular.rating, type: .popular)
                    }
                    AppText(
                        text: popular.year,
                        style: .cardTitle,
                        color: .white)
                    AppText(
                        text: popular.info,
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
#Preview {
    PopularItemView(popular: .init(
        id: 79744,
        title: "The Rookie",
        year: "2018",
        rating: 8.51,
        info: "Starting over isn't easy, especially for small-town guy John Nolan who, after a life-altering incident, is pursuing his dream of being an LAPD officer. As the force's oldest rookie, he’s met with skepticism from some higher-ups who see him as just a walking midlife crisis.",
        category: "Crime, Drama,Comedy",
        backdropPoster: "https://image.tmdb.org/t/p/w500/2m1Mu0xPj4SikiqkaolTRUcNtWH.jpg",
        mainPoster: "https://image.tmdb.org/t/p/w500/bL1mwXDnH5fCxqc4S2n40hoVyoe.jpg",
        flag: "🇬🇧"))
}
