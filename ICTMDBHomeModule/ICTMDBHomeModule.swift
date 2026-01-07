//
//  ICTMDBHomeModule.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import UIKit
import ICTMDBModularProtocols
import ICTMDBNetworkManagerKit

// MARK: - ICTMDBHomeModule
/// Responsible for creating the Home module and wiring VIPER components.
public class ICTMDBHomeModule: @MainActor HomeModuleProtocol {
    public init() { }
    @MainActor public func createHomeModule() -> UIViewController {
        
        let viewController = HomeViewController()
        
        let router = HomeRouter()
        let interactor = HomeInteractor(network: NetworkManager())
        
        let presenter: any ViewToPresenterHomeProtocol & InteractorToPresenterHomeProtocol
        = HomePresenter(view: viewController, interactor: interactor, router: router)
        viewController.presenter = presenter
        interactor.presenter = presenter
        return viewController
        
    }
}
