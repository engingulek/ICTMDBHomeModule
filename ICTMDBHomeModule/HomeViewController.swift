//
//  HomeViewController.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import Foundation
import UIKit
import GenericCollectionViewKit
import ICTMDBViewKit
import SnapKit


final class HomeViewController : UIViewController {
    var presenter: (any ViewToPresenterHomeProtocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



extension HomeViewController : PresenterToViewHomeProtocol  {
    func relaodCollectionView() {
        
    }
    
    func sendError(errorState: (isHidden: Bool, message: String)) {
        
    }
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    
}
