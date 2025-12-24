//
//  SwiftUIView.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import Kingfisher
import ICTMDBViewKit
struct HomeScreenView<VM:HomeViewModelProtocol>: View {
    @StateObject var viewModel:VM
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        
        VStack{
            if viewModel.isLoading {
                ProgressView()
            }else{
                if viewModel.isError.state{
                    AppText(text: viewModel.isError.message, style: .error)
                }else{
                    ScrollView {
                        VStack(spacing:20){
                            PopularListView(list: viewModel.popularList, sectionHeaderData: viewModel.popularSectionHeaderData)
                            AiringListView(list: viewModel.airingList, sectionHeaderData: viewModel.airingTodaySectionHeaderData)
                            Spacer()
                        }}
                }
              
            }
        }
        .onAppear{
            viewModel.onAppear()
        }
    }
}

#Preview {
    ICTMDBHomeModule.createModule()
}
