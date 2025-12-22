//
//  SwiftUIView.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import Kingfisher

struct PopularItemView: View {
    let popular: PopularTVShowPresentation
    
    var body: some View {
        ZStack {
            // 1. Arka Plan: Blur'lu Backdrop Görseli
            KFImage(URL(string: popular.backdropPoster))
                .resizable()
                .aspectRatio(contentMode: .fill)
            // Layout Priority: Arka planın içeriği ezmemesi için
            // ZStack'in boyutunu içeriğe göre belirlemesini sağlıyoruz.
                .layoutPriority(-1)
                .blur(radius: 10)
                .overlay(Color.black.opacity(0.2))
            
            // 2. İçerik Katmanı
            HStack(alignment: .top, spacing: 12) {
                
                // Sol Taraf: Ana Poster
                ZStack(alignment: .topTrailing) {
                    KFImage(URL(string: popular.mainPoster))
                        .resizable()
                        .aspectRatio(contentMode: .fit) // Oranı koruyarak sığdır
                        .frame(width: UIScreen.main.bounds.width / 3) // Sadece genişlik veriyoruz
                        .cornerRadius(8)
                    
                    Text(popular.flag)
                        .font(.system(size: 20, weight: .semibold))
                        .padding([.top, .trailing], 5)
                }
                .padding(.vertical, 10)
                .padding(.leading, 10)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .top) {
                        // Film Adı
                        Text(popular.title)
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        
                        
                        Spacer()
                        
                        RatingView(score: popular.rating, type: .popular)
                    }
                    // Tarih (dateLabel)
                    Text(popular.year)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white.opacity(0.8))
                    // Bilgi (infoLabel)
                    Text(popular.info)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                        .lineLimit(7) // Birden fazla satıra izin verir
                        .padding(.top, 4)
                    
                }.padding(.top,5)
                    .padding(.trailing,5)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 30)
        .cornerRadius(10)
        .clipped() // İçeriğin (özellikle arka planın) taşmasını engeller
    }
}
