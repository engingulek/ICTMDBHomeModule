//
//  PopularMoviesRequest.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import ICTMDBNetworkManagerKit

struct PopularMoviesRequest: NetworkRequest {
    typealias Response = DataResult<PopularTvShows>
    var language: RequestLanguage
    var page: Int
  
    var path: NetworkPath { .popular }
    var method: AlamofireMethod { .GET }
    
    var headers: [String: String]?
    
    var parameters: [String: Any]? {
        [
            "language": language,
            "page": page
        ]
    }
}
