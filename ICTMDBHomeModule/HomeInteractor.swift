//
//  HomeInteractor.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import ICTMDBNetworkManagerKit


final class HomeInteractor: PresenterToInteractorHomeProtocol {

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
    
    /// Requests popular TV shows data
    func loadPopularMovies() async {
        let request = PopularMoviesRequest(
            language: deviceLanguageCode == .turkish ? .tr : .en,
            page: 1
        )

        do {
            let list = try await network.execute(request)
             presenter?.sendPopularTvShows(list.results)
        } catch {
             presenter?.sendError(.popular)
        }
    }


    
    // MARK: - Airing Today TV Shows
    
    /// Requests airing today TV shows data
    
    func loadAiringMovies() async  {
        let request = AiringTodayRequest(
            language: deviceLanguageCode == .turkish ? .tr : .en,
            page: 1
        )
        
        do {
            let list = try await network.execute(request)
             presenter?.sendAiringTvShows(list.results)
        } catch {
             presenter?.sendError(.airingToday)
          
        }
    }
}
