//
//  HomeRouter.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import UIKit
import ICTMDBModularProtocols
import DependencyKit
import ICTMDBViewKit
public class HomeRouter : @preconcurrency PresenterToRouterHomeProtocol {
  
    @MainActor func toAllListPage(view:PresenterToViewHomeProtocol?,type: SectionType) {
        let listType : AllListType = type == .popular ? .popular : .airingToday
        let allListModule = DependencyRegister.shared.resolve(AllListModuleProtocol.self)
        let allListViewController = allListModule.createAllListModule(type: listType)
        view?.pushViewControllerAble(allListViewController, animated: true)
   
    }
    
    @MainActor func toDetailPage(view: (any PresenterToViewHomeProtocol)?, id: Int?) {
        let detailModule = DependencyRegister.shared.resolve(TvShowDetailProtocol.self)
        let detailViewController = detailModule.createTvShowDetailModule(id: id)
        view?.pushViewControllerAble(detailViewController, animated: true)
    }
    

}
