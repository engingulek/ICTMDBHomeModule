//
//  HomeService.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 22.12.2025.
//
import ICTMDBNetworkManagerKit
protocol HomeServiceProtocol {
    func getPopular(completion: @escaping (Result<[PopularTvShows], Error>) -> Void)
    func getAiring(completion: @escaping (Result<[AiringToday], Error>) -> Void)
}

final class HomeService : HomeServiceProtocol {
   
    private let networkManager : NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getPopular(completion: @escaping (Result<[PopularTvShows], any Error>) -> Void) {
        let request = PopularMoviesRequest(language: .en, page: 1)
        networkManager.execute(request) { result in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getAiring(completion: @escaping (Result<[AiringToday], any Error>) -> Void) {
        let request = AiringTodayRequest(language: .en, page: 1)
        networkManager.execute(request) { result in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
