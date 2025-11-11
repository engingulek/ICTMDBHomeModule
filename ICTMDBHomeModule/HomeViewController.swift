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
//MARK: HomeViewController
final class HomeViewController: UIViewController {
    
    var presenter: (any ViewToPresenterHomeProtocol)?
    private var collectionView: UICollectionView!
    private let acitvityIndicator  = UIActivityIndicatorView.baseActivityIndicator()
    private var dataSource: GenericCollectionDataSource<HomePresenter>?
    private var delegateSource: GenericCollectionDelegate<HomePresenter>?
    private var layout : GenericCollectionLayoutProvider<HomePresenter>?
    private var errorMessageLabeal = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        presenter?.viewDidLoad()
        setupCollectionView()
        collectionPrepareView()
        setupUI()
    }
    
    private func setupCollectionView() {
        guard let presenter = presenter as? HomePresenter else { return }
        layout = GenericCollectionLayoutProvider<HomePresenter>(source: presenter)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout!.createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.identifier)
        collectionView.register(AiringTodayCell.self, forCellWithReuseIdentifier: AiringTodayCell.identifier)
        
        collectionView.register(CHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: CHeaderView.self))
        
       
    }
    
    private func collectionPrepareView() {
        guard let presenter = presenter as? HomePresenter else { return }
        dataSource = GenericCollectionDataSource(source: presenter) { identifier, cell, item in
            guard let item = item as? CellItemType else { return }
            
            switch item {
            case .popular(let item):
                if let c = cell as? PopularCell { c.configure() }
            case .airing(let value):
                if let c = cell as? AiringTodayCell { c.configure() }
            case .none:
                break
            }
        }
        delegateSource = GenericCollectionDelegate<HomePresenter>(source: presenter)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegateSource
        view.addSubview(collectionView)
        
    }
    
    private func setupUI() {
       
        view.addSubview(errorMessageLabeal)
        errorMessageLabeal.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension HomeViewController : @MainActor PresenterToViewHomeProtocol {
    func startLoading() {
        acitvityIndicator.startAnimating()
    }
    
    func finishLoading() {
        acitvityIndicator.stopAnimating()
    }
    
    func relaodCollectionView() {
        collectionView.reloadData()
    }
    
    func sendError(errorState: (isHidden:Bool,message:String)) {
        collectionView.isHidden = errorState.isHidden
        errorMessageLabeal.text = errorState.message
        errorMessageLabeal.isHidden = !errorState.isHidden
        
    }
}

#Preview {
    let module = ICTMDBHomeModule()
    module.createHomeModule()
}

