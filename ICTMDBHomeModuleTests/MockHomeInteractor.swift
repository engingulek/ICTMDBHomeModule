//
//  MockHomeInteractor.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
@testable import ICTMDBHomeModule

final class MockHomeInteractor : PresenterToInteractorHomeProtocol {
    var presenter: (any InteractorToPresenterHomeProtocol)?
    
    var loadError : Bool = false
    var airingTodayList : [AiringToday] = []
    var popularList : [PopularTvShows] = []
    
    func loadPopularMovies() {
        if loadError {
            presenter?.sendError(.popular)
        }else{
            print("testila")
            presenter?.sendPopularTvShows(popularList)
        }
    }
    
    func loadAiringMovies() {
        if loadError {
            presenter?.sendError(.airingToday)
        }else{
            presenter?.sendAiringTvShows(airingTodayList)
        }
        
        
    }
}
