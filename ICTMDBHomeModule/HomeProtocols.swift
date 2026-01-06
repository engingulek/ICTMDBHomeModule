//
//  HomeProtocols.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import ICTMDBViewKit
import GenericCollectionViewKit


import UIKit

// MARK: - Typealias
/// Combines UIViewAble and SegueAble protocols for convenience.
typealias Ables = UIViewAble & SegueAble & NavConUIAble

// MARK: - View → Presenter
/// Protocol for communication from View to Presenter.
@MainActor
protocol ViewToPresenterHomeProtocol: AnyObject,
    GenericCollectionDataSourceProtocol,
    GenericCollectionDelegateSourceProtocol,
    GenericCollectionLayoutProviderProtocol {
    
    /// Reference to the View layer
    var view: PresenterToViewHomeProtocol? { get }
    
    /// Called when the view is loaded
    func viewDidLoad()
   
}

// MARK: - Presenter → View
/// Protocol for communication from Presenter to View.
protocol PresenterToViewHomeProtocol: AnyObject, Ables {
    
    /// Reloads the collection view data
    func relaodCollectionView()
    
    /// Displays or hides an error message
    func sendError(errorState: (isHidden: Bool, message: String))
    
    /// Starts a loading indicator
    func startLoading()
    
    /// Stops a loading indicator
    func finishLoading()
}

// MARK: - Presenter → Interactor
/// Protocol defining communication from Presenter to Interactor.

protocol PresenterToInteractorHomeProtocol:Sendable,AnyObject {

    /// Reference to the Presenter layer
    var presenter: InteractorToPresenterHomeProtocol? { get set }

   // Requests data
    func loadData() async
}


// MARK: - Interactor → Presenter
/// Protocol for sending data or errors from Interactor to Presenter.
protocol InteractorToPresenterHomeProtocol : AnyObject{
    
    func sendData(popular:[PopularTvShows],airingToday:[AiringToday])
    
    /// Sends an error state
    func sendError()
    
}

// MARK: - Presenter → Router
/// Protocol for navigation actions from Presenter to Router.

protocol PresenterToRouterHomeProtocol {
    
    /// Navigates to All List page
    func toAllListPage(view: PresenterToViewHomeProtocol?, type: SectionType)
    
    /// Navigates to Detail page
    func toDetailPage(view: PresenterToViewHomeProtocol?, id: Int?)
}



