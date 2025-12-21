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

    func loadData() async {
        if loadError {
            presenter?.sendError()
        }else{
            presenter?.sendPopularTvShows(popularList)
            presenter?.sendAiringTvShows(airingTodayList)
        }
    }
}
