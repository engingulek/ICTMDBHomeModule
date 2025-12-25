//
//  HomeViewModel.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//

import Foundation
import ICTMDBViewKit

struct SectionHeaderData {
    let icon:String
    let title:String
}

enum onTappedAllList {
    case popular
    case airingToday
}

protocol HomeViewModelProtocol : ObservableObject{
    var popularList:[PopularTVShowPresentation] {get}
    var airingList:[AiringTodayPresentation] {get}
    var popularSectionHeaderData:SectionHeaderData {get}
    var airingTodaySectionHeaderData:SectionHeaderData{get}
    var isLoading:Bool {get}
    var isError:(state:Bool,message:String) {get}
    var toAllList: ((onTappedAllList) -> Void)? { get set }
    var toDetail:((Int?) -> Void)?  { get set }
    func onTappedAllListAction(_ action:onTappedAllList)
    func onTappedItem(id:Int?)
   
}

final class HomeViewModel : HomeViewModelProtocol {
    @Published var popularList: [PopularTVShowPresentation] = []
    @Published var airingList:[AiringTodayPresentation] = []
    @Published var popularSectionHeaderData: SectionHeaderData = .init(
        icon: "flame.fill",
        title: LocalizableUI.popular.localized)
    @Published var airingTodaySectionHeaderData: SectionHeaderData = .init(
        icon: "circle.fill",
        title: LocalizableUI.airingToday.localized)
    @Published var isLoading: Bool = false
    @Published var isError: (state:Bool,message:String) = (state:false,message:"")
    var toAllList: ((onTappedAllList) -> Void)?
    var toDetail:((Int?)->Void)?
    private var isPopularLoading : Bool = false
    private var isAiringLoading : Bool = false
    private var service : HomeServiceProtocol
    init(service: HomeServiceProtocol) {
        self.service = service
        loadData()
    }
    

    
    private func loadData() {
        isLoading = true
        isPopularLoading = true
        isAiringLoading = true
        
        service.getPopular { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let list = data.map { PopularTVShowPresentation(tvShow: $0) }
                popularList = list.sorted{ $0.rating > $1.rating}
                isPopularLoading = false
                isLoading = isPopularLoading || isAiringLoading
                
            case .failure:
                popularList = []
                airingList = []
                isPopularLoading = false
                isLoading = isPopularLoading || isAiringLoading
                isError = (state:true,message:LocalizableUI.somethingWentWrong.localized)
            }
        }
        
        service.getAiring { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                airingList = data.map { AiringTodayPresentation(tvShow: $0) }
                isAiringLoading = false
                isLoading = isPopularLoading || isAiringLoading
            case .failure:
                popularList = []
                airingList = []
                isAiringLoading = false
                isLoading = isPopularLoading || isAiringLoading
                isError = (state:true,message:LocalizableUI.somethingWentWrong.localized)
            }
        }
    }
    
    func onTappedAllListAction(_ action: onTappedAllList) {
        toAllList?(action)
    }
    
    func onTappedItem(id: Int?) {
        toDetail?(id)
    }
}
