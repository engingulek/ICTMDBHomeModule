//
//  HomeInteractor.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import ICTMDBNetworkManagerKit

final class HomeInteractor : @preconcurrency PresenterToInteractorHomeProtocol {
    var presenter: (any InteractorToPresenterHomeProtocol)?
   
    private let network : NetworkManagerProtocol
    
    let deviceLanguageCode = Locale.current.language.languageCode ?? .english
    
    
    init(network: NetworkManagerProtocol) {
 
        self.network = network
    }
    
     func loadPopularMovies() {
        let request = PopularMoviesRequest(
            language: deviceLanguageCode == .turkish ? .tr : .en,
            page: 1)
        
        
        network.execute(request) {[weak self] result in
            guard let self else {return}
            switch result {
            case .success(let  list):
                presenter?.sendPopularTvShows(list.results)
            case .failure:
                presenter?.sendError(.popular)
            }
        }
    }
    
     func loadAiringMovies() {
        let request = AiringTodayRequest(
            language: deviceLanguageCode == .turkish ? .tr : .en,
            page: 1)
        network.execute(request) { [weak self] result in
            guard let self else {return}
            switch result {
            case .success(let list):
                presenter?.sendAiringTvShows(list.results)
            case .failure:
                presenter?.sendError(.airingToday)
            }
        }
    }
}
