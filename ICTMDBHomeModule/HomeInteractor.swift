//
//  HomeInteractor.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import ICTMDBNetworkManagerKit


final class HomeInteractor: PresenterToInteractorHomeProtocol,@unchecked Sendable {
  
    // MARK: - Properties
    
    /// Reference to the Presenter to send data or errors back.
   weak var presenter: (any InteractorToPresenterHomeProtocol)?
    
    /// Network manager responsible for API requests.
    private let network: NetworkManagerProtocol
    
    /// Current device language code (e.g., tr, en).
    let deviceLanguageCode = Locale.current.language.languageCode ?? .english
    
    init(network: NetworkManagerProtocol) {
        self.network = network
    }
    
    func loadData() async {
        let popularMoviesRequest = PopularMoviesRequest(language: deviceLanguageCode == .turkish ? .tr : .en, page: 1)
        let airingTodayRequest = AiringTodayRequest(language: deviceLanguageCode == .turkish ? .tr : .en, page: 1)
        async let popularMovies = network.execute(popularMoviesRequest)
        
        async let airingMovies = network.execute(airingTodayRequest)

        do {
            let (popularResult, airingResult) = try await (popularMovies, airingMovies)
            
            await presenter?.sendData(
                    popular: popularResult.results,
                    airingToday: airingResult.results)
                       
                    
        } catch {
            await presenter?.sendError()
                    
        }
    }
}
