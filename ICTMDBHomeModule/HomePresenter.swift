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

// MARK: - HomePresenter
/// Handles the presentation logic for the Home module.

final class HomePresenter {
    private var loadTask: Task<Void, Never>?
    // MARK: - Typealias
    /// Typealias for cell items displayed in collection view
    typealias CellItem = CellItemType
    
    // MARK: - Properties
    
    /// Reference to the View layer
    weak var view: PresenterToViewHomeProtocol?
    
    /// Reference to the Interactor layer
    private var interactor: PresenterToInteractorHomeProtocol
    
    /// Reference to the Router layer
    private var router: PresenterToRouterHomeProtocol
    
    /// List of popular TV shows for UI display
    private var popularTvShows: [PopularTVShowPresentation] = []
    
    /// List of airing today shows for UI display
    private var airingTodayShows: [AiringTodayPresentation] = []
    
    
    // MARK: - Init
    init(view: PresenterToViewHomeProtocol?,
         interactor: PresenterToInteractorHomeProtocol,
         router: PresenterToRouterHomeProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    deinit {
        loadTask?.cancel()
    }
}


// MARK: - ViewToPresenterHomeProtocol
/// Handles actions triggered by the View layer.
@MainActor
extension HomePresenter: ViewToPresenterHomeProtocol {
    
    
    
    func viewDidLoad() {
        view?.setBackColorAble(color: "backColor")
        view?.setNavigationTitle(title: LocalizableUI.homePageNavTitle.localized)
        
        loadTask = Task {
            await loadData()
        }
    }
    
    
    
    func loadData() async {
        view?.startLoading()
        await interactor.loadData()
        view?.finishLoading()
    }
    
   
    
}


// MARK: - CollectionViewSources
/// Provides collection view data, layout, and interaction logic.
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
        guard let sectionType = SectionType(rawValue: section) else { return 0 }
        switch sectionType {
        case .popular: return popularTvShows.count
        case .airingToday: return airingTodayShows.count
        }
    }
    
    
    func numberOfSections() -> Int {
        SectionType.allCases.count
    }
    
    func cellForItem(section: Int, item: Int) -> CellItemType {
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
        guard let sectionType = SectionType(rawValue: section) else { return }
        switch sectionType {
        case .popular:
            let id = popularTvShows[item].id
            router.toDetailPage(view: view, id: id)
        case .airingToday:
            let id = airingTodayShows[item].id
            router.toDetailPage(view: view, id: id)
        }
    }
    
    func titleForSection(at section: Int) -> GenericCollectionViewKit.HeaderViewItem {
        var headerViewItem:HeaderViewItem
        guard let sectionType = SectionType(rawValue: section) else {
            headerViewItem = .init(title: "", sizeType: .empty)
            return headerViewItem
        }
        
        switch sectionType {
        case .popular:
            headerViewItem = .init(
                title: LocalizableUI.popular.localized,
                icon: .init(image: .systemImage("flame.fill"), tintColor: .custom(hex: "#FF0000")),
                sizeType: .large,
                buttonTypes: [.allList])
        case .airingToday:
            headerViewItem = .init(
                title: LocalizableUI.airingToday.localized,
                icon: .init(image: .systemImage("circle.fill"), tintColor: .custom(hex: "#008000")),
                sizeType: .large,
                buttonTypes: [.allList])
        }
        return headerViewItem
    }
    
    
    func onTappedTitleButton(buttonType: TitleForSectionButtonType, section: Int) {
        guard let sectionType = SectionType(rawValue: section) else { return }
        
        switch sectionType {
        case .popular:
            switch buttonType {
            case .allList:
                router.toAllListPage(view: view, type: .popular)
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
        guard let section = SectionType(rawValue: section) else { return "" }
        switch section {
        case .popular: return PopularCell.identifier
        case .airingToday: return AiringTodayCell.identifier
        }
    }
}


// MARK: - InteractorToPresenterHomeProtocol
/// Receives data from the Interactor and updates the view.
extension HomePresenter: InteractorToPresenterHomeProtocol {
    func sendError() {
        
        view?.sendError(errorState: (isHidden: true,
                                     message: LocalizableUI.somethingWentWrong.localized))
        view?.relaodCollectionView()
        
    }
    
    
    func sendAiringTvShows(_ data: [AiringToday]) {
        
        airingTodayShows = data.map { AiringTodayPresentation(tvShow: $0) }
        view?.sendError(errorState: (isHidden: false, message: ""))
        view?.relaodCollectionView()
        
    }
    
    func sendPopularTvShows(_ data: [PopularTvShows]) {
        
        popularTvShows = data
            .map { PopularTVShowPresentation(tvShow: $0) }
            .sorted { $0.rating > $1.rating }
        view?.sendError(errorState: (isHidden: false, message: ""))
        view?.relaodCollectionView()
        
    }
}

