//
//  SwiftUIView.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import ICTMDBViewKit
struct PopularListView: View {
    let list : [PopularTVShowPresentation]
    var sectionHeaderData:SectionHeaderData
    var body: some View {
        VStack{
            SectionHeader(
                iconName: sectionHeaderData.icon,
                iconColor: .red,
                title:sectionHeaderData.title) {
            }
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(list,id: \.id) { popular in
                       PopularItemView(popular: popular)
                            
                    }
                }
            }
        }.padding(.horizontal)
    }
}

