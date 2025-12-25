//
//  ICTMDBHomeModule.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import SwiftUI
import ICTMDBNetworkManagerKit
import ICTMDBModularProtocols
public final class ICTMDBHomeModule : @MainActor HomeModuleProtocol {
    public init() {}
    @MainActor public func createHomeModule() -> AnyView {
        let view = HomeScreenView(viewModel: HomeViewModel(service: HomeService(networkManager: NetworkManager())))
        return AnyView(view)
    }
}
