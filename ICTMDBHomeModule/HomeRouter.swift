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

import UIKit

/// `HomeRouter` is responsible for navigation in the Home module.
public class HomeRouter:  PresenterToRouterHomeProtocol {
    
    // MARK: - Navigation to All List Page
    
    /// Navigates to the All List screen based on the selected section type.
    /// - Parameters:
    ///   - view: The current view conforming to `PresenterToViewHomeProtocol`.
    ///   - type: The section type (e.g., popular or airingToday).
  
    func toAllListPage(view: PresenterToViewHomeProtocol?, type: SectionType) {
        // Determine the list type based on section
        let listType: AllListType = type == .popular ? .popular : .airingToday
        
        // Resolve AllList module dependency from DependencyRegister
        let allListModule = DependencyRegister.shared.resolve(AllListModuleProtocol.self)
        
        // Create the AllList view controller using module
        let allListViewController = allListModule.createAllListModule(type: listType)
        
        view?.pushViewControllerAble(allListViewController, animated: true)
    }
    
    // MARK: - Navigation to Detail Page
    
    /// Navigates to the TV show detail page.
    /// - Parameters:
    ///   - view: The current view conforming to `PresenterToViewHomeProtocol`.
    ///   - id: The TV show ID to display details for.

    func toDetailPage(view: (any PresenterToViewHomeProtocol)?, id: Int?) {
        // Resolve Detail module dependency from DependencyRegister
        // Detail modülünü DependencyRegister üzerinden alır
        let detailModule = DependencyRegister.shared.resolve(TvShowDetailProtocol.self)
        
        // Create the Detail view controller using module
        // Modül üzerinden Detail view controller oluşturur
        let detailViewController = detailModule.createTvShowDetailModule(id: id)
        
        view?.pushViewControllerAble(detailViewController, animated: true)
    }
}
