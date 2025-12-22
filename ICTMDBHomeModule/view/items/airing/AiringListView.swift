//
//  SwiftUIView.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import Kingfisher
struct AiringListView: View {
    let list:[AiringTodayPresentation]
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 20,height: 25)
                    .foregroundStyle(.green)
                Text("Airing List")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text("All List")
                    .font(.title3)
                    .fontWeight(.semibold)
            }.padding(.horizontal)
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(list, id: \.id) { item in
                    VStack(spacing: 0) { // Spacing 0 verip padding ile yönetmek daha hassas sonuç verir
                        
                        // 1. GÖRSEL VE BAYRAK KATMANI
                        ZStack(alignment: .topTrailing) {
                            KFImage(URL(string: item.mainPoster))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 220)
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .overlay(alignment: .topTrailing) {
                                    Text(item.flag)
                                        .padding([.top, .trailing], 8)
                                }
                                .overlay(alignment: .bottomTrailing) {
                                    RatingView(score: item.rating, type: .airingToday)
                                        .padding([.bottom, .trailing], 8)
                                }
                            
                            Text(item.flag)
                                .font(.system(size: 18))
                                .cornerRadius(6)
                                .padding([.top, .trailing], 8)
                        }
                      
                  
                            Text(item.title)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.primary)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                              
                   
                          
                      
                     
                        
                        Spacer(minLength: 0)
                    }
                    .background(Color(.secondarySystemGroupedBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.systemGray5), lineWidth: 0.5)
                    )
                }
            }
        }
       
        .padding(.horizontal)
    }
}

