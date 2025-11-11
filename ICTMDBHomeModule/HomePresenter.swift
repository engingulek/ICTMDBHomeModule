//
//  HomePresenter.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import GenericCollectionViewKit
import ICTMDBViewKit

//MARK: CellItemType


//MARK: HomePresenter
final class HomePresenter {
    typealias CellItem = CellItemType
    weak var view: PresenterToViewHomeProtocol?
    private var interactor : PresenterToInteractorHomeProtocol
    private var router : PresenterToRouterHomeProtocol
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
       
    }
    
    func numberOfRowsInSection(in section: Int) -> Int {
        
    }
    
    func numberOfSections() -> Int {
       
    }
    
    func cellForItem(section: Int,item:Int) -> CellItemType {
       
      
        
    }
    
    func didSelectItem(at indexPath: IndexPath) {
       
    }
    
    func titleForSection(at section: Int) ->(
        title: String, sizeType:SectionSizeType,
        buttonType: [TitleForSectionButtonType]?) {
            
           
        }
    
    func onTappedTitleButton(buttonType: TitleForSectionButtonType, section: Int) {
        
    }
    
    func sectionType(at section: Int) -> SectionType {
      
    }
    
    func cellIdentifier(at section: Int) -> String {
        
    }
}

//MARK: HomePresenter: InteractorToPresenterHomeProtocol
extension HomePresenter: InteractorToPresenterHomeProtocol {
    func sendAiringTvShows() {
       
    }
    
    func sendPopularTvShows() {
        
    }
    
    func sendError() {
       
    }
}
