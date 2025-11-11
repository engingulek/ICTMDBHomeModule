//
//  AiringTodayCell.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import UIKit
import SnapKit
import ICTMDBViewKit

final class AiringTodayCell: UICollectionViewCell {
    static let identifier = "AiringTodayCell"

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        contentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SetupUI
    private func setupUI() {
        
     
    }
    
    //MARK: Configure
    func configure() {
        
    }
}
