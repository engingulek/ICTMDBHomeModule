//
//  AiringTodayRequest.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import ICTMDBNetworkManagerKit

//MARK: AiringTodayRequest
struct AiringTodayRequest :NetworkRequest {
    typealias Response = DataResult<AiringToday>
    var language: RequestLanguage
    var page: Int
  
    var path: NetworkPath { .airingToday }
    var method: AlamofireMethod { .GET }
    
    var headers: [String: String]?
    
    var parameters: [String: Any]? {
        [
            "language": language,
            "page": page
        ]
    }
}
