//
//  SwiftUIView.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import Kingfisher
import ICTMDBViewKit
struct AiringListView: View {
    let list:[AiringTodayPresentation]
    var sectionHeaderData:SectionHeaderData
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack{
            SectionHeader(iconName: sectionHeaderData.icon,
                          iconColor: .green,
                          title: sectionHeaderData.title) {
            }
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(list, id: \.id) { item in
                    AiringTodayItem(item: item)
                }
            }
        }
       
        .padding(.horizontal)
    }
}

#Preview {
    AiringListView(list: [
        .init(id: 1, title: "The Rookie", flag: "🇬🇧",
              rating: 8.51,
              mainPoster: "https://image.tmdb.org/t/p/w500/bL1mwXDnH5fCxqc4S2n40hoVyoe.jpg"),
        .init(id: 2, title: "IT: Welcome to Derry", flag: "🇬🇧",
              rating: 8.51,
              mainPoster: "https://image.tmdb.org/t/p/w500/nyy3BITeIjviv6PFIXtqvc8i6xi.jpg")],
                   sectionHeaderData: .init(icon: "circle..fill", title: "Airing Today"))
}
