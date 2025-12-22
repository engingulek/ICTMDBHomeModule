//
//  SwiftUIView.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
struct PopularListView: View {
    let list : [PopularTVShowPresentation]
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "flame.fill")
                    .resizable()
                    .frame(width: 20,height: 25)
                    .foregroundStyle(.red)
                Text("Popular List")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text("All List")
                    .font(.title3)
                    .fontWeight(.semibold)
            }.padding(.horizontal)
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

