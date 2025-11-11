//
//  HomeProtocols.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import ICTMDBViewKit
import GenericCollectionViewKit


typealias Ables = UIViewAble & SegueAble

protocol ViewToPresenterHomeProtocol: AnyObject,
   GenericCollectionDataSourceProtocol,
   GenericCollectionDelegateSourceProtocol,
                                     GenericCollectionLayoutProviderProtocol{
   var view : PresenterToViewHomeProtocol? {get}
   func viewDidLoad()
}


protocol PresenterToViewHomeProtocol : AnyObject,Ables{
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
    func toAllListPage(view:PresenterToViewHomeProtocol?,type:SectionType)
   func toDetailPage(view:PresenterToViewHomeProtocol?,id:Int?)
}


