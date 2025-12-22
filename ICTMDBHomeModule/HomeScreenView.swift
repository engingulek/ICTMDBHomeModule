//
//  SwiftUIView.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import SwiftUI
import Kingfisher
struct HomeScreenView<VM:HomeViewModelProtocol>: View {
    @StateObject var viewModel:VM
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            VStack(spacing:20){
            PopularListView(list: viewModel.popularList)
            AiringListView(list: viewModel.airingList)
               
           
               
                
                Spacer()
            }}.onAppear{
            viewModel.task()
        }
    }
}

#Preview {
    ICTMDBHomeModule.createModule()
}
