//
//  SwiftUIView.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import ICTMDBNavigationManagerSwiftUI
import ICTMDBViewKit
struct HomeScreenView<VM:HomeViewModelProtocol>: View {
    @StateObject var viewModel:VM
    @EnvironmentObject private var navigation:Navigation
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
                            PopularListView(
                                list: viewModel.popularList,
                                sectionHeaderData: viewModel.popularSectionHeaderData) {
                                    viewModel.onTappedAllListAction(.popular)
                                } onTappedItem: { id in
                                    viewModel.onTappedItem(id: id)
                                }

                            AiringListView(
                                list: viewModel.airingList,
                                sectionHeaderData: viewModel.airingTodaySectionHeaderData){
                                viewModel.onTappedAllListAction(.airingToday)
                                } onTappedItem: { id in
                                    viewModel.onTappedItem(id: id)
                                }
                            Spacer()
                        }}
                }
              
            }
        }
        .onAppear{
           
            viewModel.toAllList = {[weak navigation] action in
                guard let navigation else {return}
                switch action {
                case .popular:
                    navigation.push(.allList(.popular))
                case .airingToday:
                    navigation.push(.allList(.airingToday))
                }
            }
            
            viewModel.toDetail = {[weak navigation] id in
                guard let navigation else {return}
                navigation.push(.detail(id))
            }
        }
    }
}

#Preview {
    let module = ICTMDBHomeModule()
    module.createHomeModule()
}
