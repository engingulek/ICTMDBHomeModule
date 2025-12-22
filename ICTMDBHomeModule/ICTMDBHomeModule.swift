//
//  ICTMDBHomeModule.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import SwiftUI

import ICTMDBNetworkManagerKit

final class ICTMDBHomeModule {
    @MainActor   static func createModule() -> AnyView{
        let view = HomeScreenView(viewModel: HomeViewModel(service: HomeService(networkManager: NetworkManager())))
        return AnyView(view)
    }
}
