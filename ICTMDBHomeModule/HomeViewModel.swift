//
//  HomeViewModel.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import Foundation

protocol HomeViewModelProtocol : ObservableObject{
    var popularList:[PopularTVShowPresentation] {get}
    var airingList:[AiringTodayPresentation] {get}
    func task()
}

final class HomeViewModel : HomeViewModelProtocol {
    @Published var popularList: [PopularTVShowPresentation] = []
    @Published var airingList:[AiringTodayPresentation] = []
    private var service : HomeServiceProtocol
    init(service: HomeServiceProtocol) {
     
        self.service = service
    }
    
    func task()  {
        service.getPopular { result in
            switch result {
            case .success(let data):
                self.popularList = data
                    .map { PopularTVShowPresentation(tvShow: $0) }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
        service.getAiring { result in
            switch result {
            case .success(let data):
                self.airingList = data.map{AiringTodayPresentation(tvShow: $0) }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
}
