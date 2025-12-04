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


// MARK: - HomeViewController
/// The main view controller of the Home module.
final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Presenter reference (connects View and Presenter in VIPER)
    var presenter: (any ViewToPresenterHomeProtocol)?
    
    /// Main collection view
    private var collectionView: UICollectionView!
    
    /// Loading indicator for API operations
    private let acitvityIndicator = UIActivityIndicatorView.baseActivityIndicator()
    
    /// Generic collection view data source
    private var dataSource: GenericCollectionDataSource<HomePresenter>?
    
    /// Generic delegate handler for collection view
    private var delegateSource: GenericCollectionDelegate<HomePresenter>?
    
    /// Collection view layout provider
    private var layout: GenericCollectionLayoutProvider<HomePresenter>?
    
    /// Label to display error messages
    private var errorMessageLabeal = UILabel()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        presenter?.viewDidLoad()
        setupCollectionView()
        collectionPrepareView()
        setupUI()
       
    }
    
    
    // MARK: - Setup Methods

    /// Sets up the collection view and its layout.
    private func setupCollectionView() {
        guard let presenter = presenter as? HomePresenter else { return }
        layout = GenericCollectionLayoutProvider<HomePresenter>(source: presenter)
        
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: layout!.createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
   
        collectionView.register(PopularCell.self,
                                forCellWithReuseIdentifier: PopularCell.identifier)
        collectionView.register(AiringTodayCell.self,
                                forCellWithReuseIdentifier: AiringTodayCell.identifier)
        
        collectionView.register(CHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: CHeaderView.self))
    }
    
    
    /// Prepares and assigns the collection view's data source and delegate.
    private func collectionPrepareView() {
        guard let presenter = presenter as? HomePresenter else { return }
        
        dataSource = GenericCollectionDataSource(source: presenter) { identifier, cell, item in
            guard let item = item as? CellItemType else { return }
            
            switch item {
            case .popular(let item):
                if let c = cell as? PopularCell { c.configure(with: item) }
            case .airing(let value):
                if let c = cell as? AiringTodayCell { c.configure(with: value) }
            case .none:
                break
            }
        }
        
        delegateSource = GenericCollectionDelegate<HomePresenter>(source: presenter)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegateSource
        view.addSubview(collectionView)
    }
    
    
    /// Sets up the general user interface elements.
    private func setupUI() {
        view.addSubview(errorMessageLabeal)
        errorMessageLabeal.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}


// MARK: - PresenterToViewHomeProtocol
/// Implements the methods that allow the presenter to update the view.
extension HomeViewController: @MainActor PresenterToViewHomeProtocol {
    
    func startLoading() {
        acitvityIndicator.startAnimating()
    }
    
    func finishLoading() {
        acitvityIndicator.stopAnimating()
    }
    
    func relaodCollectionView() {
        collectionView.reloadData()
    }
    
    func sendError(errorState: (isHidden: Bool, message: String)) {
        collectionView.isHidden = errorState.isHidden
        errorMessageLabeal.text = errorState.message
        errorMessageLabeal.isHidden = !errorState.isHidden
    }
}


// MARK: - Preview
#Preview {
    let module = ICTMDBHomeModule()
    UINavigationController(rootViewController: module.createHomeModule())
}
