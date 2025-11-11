//
//  HomePresenter.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import GenericCollectionViewKit
import ICTMDBViewKit
import UIKit

//MARK: CellItemType


//MARK: HomePresenter
final class HomePresenter {
    typealias CellItem = CellItemType
    weak var view: PresenterToViewHomeProtocol?
    private var interactor : PresenterToInteractorHomeProtocol
    private var router : PresenterToRouterHomeProtocol
    private var popularTvShows : [PopularTVShowPresentation] = []
    private var airingTodayShows : [AiringTodayPresentation] = []
    init(view: PresenterToViewHomeProtocol?,
         interactor:PresenterToInteractorHomeProtocol,
         router : PresenterToRouterHomeProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

//MARK: HomePresenter : ViewToPresenterHomeProtocol
extension HomePresenter : ViewToPresenterHomeProtocol {
    
    func viewDidLoad() {
        view?.setBackColorAble(color: "backColor")
        interactor.loadPopularMovies()
        interactor.loadAiringMovies()
    }
}

//MARK: CollectionViewSources
extension HomePresenter {
    func layout(for sectionIndex: Int) -> LayoutSource {
        guard let sectionType = SectionType(rawValue: sectionIndex) else {
            return LayoutSourceTeamplate.none.template
        }
        switch sectionType {
        case .popular:
            return LayoutSourceTeamplate.horizontalSingleRow.template
        case .airingToday:
            return LayoutSourceTeamplate.verticalTwoPerRow.template
        }
    }
    
    func numberOfRowsInSection(in section: Int) -> Int {
        guard let sectionType = SectionType(rawValue: section) else {return 0}
        switch sectionType {
        case .popular:
            return popularTvShows.count
        case .airingToday:
            return  airingTodayShows.count
        }
    }
    
    func numberOfSections() -> Int {
        SectionType.allCases.count
    }
    
    func cellForItem(section: Int,item:Int) -> CellItemType {
       
        guard let sectionType = SectionType(rawValue: section) else { return .none }
        switch sectionType {
        case .popular:
            let tvShow = popularTvShows[item]
            return .popular(tvShow)
        case .airingToday:
            let tvShow = airingTodayShows[item]
            return .airing(tvShow)
        }
        
    }
    
    func didSelectItem(section: Int, item: Int) {
        guard let sectionType = SectionType(rawValue: section) else { return  }
        switch sectionType {
        case .popular:
            let id = popularTvShows[item].id
            router.toDetailPage(view: view, id: id)
        case .airingToday:
            let id = airingTodayShows[item].id
            router.toDetailPage(view: view, id: id)
        }
    }
 
    func titleForSection(at section: Int) ->(
        title: String, sizeType:SectionSizeType,
        buttonType: [TitleForSectionButtonType]?) {
            
            guard let sectionType = SectionType(rawValue: section)
            else { return  (title:"",sizeType:.small,buttonType:[]) }
            
            var item : (
                title: String,
                sizeType: SectionSizeType,
                buttonType: [TitleForSectionButtonType]?)
            
            switch sectionType {
            case .popular:
                item = (title:LocalizableUI.popular.localized,sizeType:.large,buttonType:[.allList])
            case .airingToday:
                item = (title:LocalizableUI.airingToday.localized,sizeType:.small,buttonType:[.allList])
            }
            return item
        }
    
    func onTappedTitleButton(buttonType: TitleForSectionButtonType, section: Int) {
        guard let sectionType = SectionType(rawValue: section) else { return }
        
        switch sectionType {
        case .popular:
            switch buttonType {
            case .allList:
                router.toAllListPage(view: view, type: .popular)
                print("Popular All List")
            default:
                break
            }
            
        case .airingToday:
            switch buttonType {
            case .allList:
                router.toAllListPage(view: view, type: .airingToday)
            default:
                break
            }
        }
    }
    
    func sectionType(at section: Int) -> SectionType {
        return SectionType(rawValue: section) ?? .popular
    }
    
    func cellIdentifier(at section: Int) -> String {
        guard let section  = SectionType(rawValue: section) else {return ""}
        switch section {
        case .popular: return PopularCell.identifier
        case .airingToday: return AiringTodayCell.identifier
            
        }
    }
}

//MARK: HomePresenter: InteractorToPresenterHomeProtocol
extension HomePresenter: InteractorToPresenterHomeProtocol {
    func sendAiringTvShows(_ data: [AiringToday]) {
        view?.startLoading()
        airingTodayShows  = data.map {
            AiringTodayPresentation(
                tvShow: $0)}
        view?.sendError(errorState: (isHidden: false, message: ""))
        view?.relaodCollectionView()
        view?.finishLoading()
    }
    
    func sendPopularTvShows(_ data: [PopularTvShows]) {
        view?.startLoading()
        popularTvShows = data.map {PopularTVShowPresentation(
            tvShow: $0)}.sorted{$0.rating > $1.rating }
        view?.sendError(errorState: (isHidden: false, message: ""))
        view?.relaodCollectionView()
        view?.finishLoading()
    }
    
    func sendError(_ type: HomePageErrorType) {
        view?.startLoading()
        view?.sendError(errorState: (isHidden: true, message: LocalizableUI.somethingWentWrong.localized))
        view?.relaodCollectionView()
        view?.finishLoading()
    }
}
