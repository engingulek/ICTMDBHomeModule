//
//  HomeProtocols.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import UIKit



protocol ViewToPresenterHomeProtocol: AnyObject
  {
    var view : PresenterToViewHomeProtocol? {get}
    func viewDidLoad()
}


protocol PresenterToViewHomeProtocol : AnyObject{
    func relaodCollectionView()
    func sendError(errorState: (isHidden:Bool,message:String))
    func startLoading()
    func finishLoading()
}


protocol PresenterToInteractorHomeProtocol {
    var presenter: InteractorToPresenterHomeProtocol? {get set}
    func loadPopularMovies()
    func loadAiringMovies()
}


protocol InteractorToPresenterHomeProtocol {
    func sendPopularTvShows()
    func sendAiringTvShows()
    func sendError()
}

protocol PresenterToRouterHomeProtocol {
    func toAllListPage(view:PresenterToViewHomeProtocol?)
    func toDetailPage(view:PresenterToViewHomeProtocol?)
}


