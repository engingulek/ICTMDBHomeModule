//
//  PopularCell.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import UIKit
import SnapKit
import ICTMDBViewKit

final class PopularCell: UICollectionViewCell {
    static let identifier: String = "PopularCell"
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setupUI
    private func setupUI() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    //MARK: Configure
    func configure() {
       
    }
    
    //MARK: ConfigureUI
    func configureUI() {
        
    }
    
    
}
