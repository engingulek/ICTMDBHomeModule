//
//  HomeInteractor.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import ICTMDBNetworkManagerKit

import Foundation

/// `HomeInteractor` handles the data-fetching logic for the Home module.
final class HomeInteractor: @preconcurrency PresenterToInteractorHomeProtocol {
    
    // MARK: - Properties
    
    /// Reference to the Presenter to send data or errors back.
    var presenter: (any InteractorToPresenterHomeProtocol)?
    
    /// Network manager responsible for API requests.
    private let network: NetworkManagerProtocol
    
    /// Current device language code (e.g., tr, en).
    let deviceLanguageCode = Locale.current.language.languageCode ?? .english
    
 
    init(network: NetworkManagerProtocol) {
        self.network = network
    }
    
    // MARK: - Popular TV Shows
    
    /// Loads the list of popular TV shows from the API.
    func loadPopularMovies() {
        let request = PopularMoviesRequest(
            language: deviceLanguageCode == .turkish ? .tr : .en,
            page: 1
        )
        
        // Executes the network request asynchronously.
        network.execute(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let list):
                // Sends the fetched popular shows to the Presenter.
                presenter?.sendPopularTvShows(list.results)
                
            case .failure:
                // Notifies Presenter of an error.
                presenter?.sendError(.popular)
            }
        }
    }
    
    // MARK: - Airing Today TV Shows
    
    /// Loads the list of TV shows airing today.
    func loadAiringMovies() {
        let request = AiringTodayRequest(
            language: deviceLanguageCode == .turkish ? .tr : .en,
            page: 1
        )
        
        // Executes the network request asynchronously.
        network.execute(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let list):
                // Sends the fetched airing shows to the Presenter.
                presenter?.sendAiringTvShows(list.results)
                
            case .failure:
                // Notifies Presenter of an error.
                presenter?.sendError(.airingToday)
            }
        }
    }
}

