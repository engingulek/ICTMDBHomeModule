//
//  MockHomeRouter.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import UIKit
@testable import ICTMDBHomeModule

final class MockHomeRouter : PresenterToRouterHomeProtocol {
    
    
    var invokedPopular = false
    
    
    var invokedAiring = false
    
    
    func toAllListPage(view: (any PresenterToViewHomeProtocol)?, type: SectionType) {
        switch type {
        case .popular:
            invokedPopular = true
        case .airingToday:
            invokedAiring = true
        }
        
    }
    
    var invokedtoDetail = false
    func toDetailPage(view: (any PresenterToViewHomeProtocol)?, id: Int?) {
        invokedtoDetail = true
    }
    
    
}
