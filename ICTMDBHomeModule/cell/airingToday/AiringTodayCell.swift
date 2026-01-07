//
//  AiringTodayCell.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import UIKit
import SnapKit
import ICTMDBViewKit

// MARK: AiringTodayCell
final class AiringTodayCell: UICollectionViewCell {
    static let identifier = "AiringTodayCell"
    private lazy var posterImageView = ImageViewFactory.createImageView(ofType: .main)
    
    private lazy var titleLabel = LabelFactory.createLabel(
        ofType: .cellLargeTitle(weight: .semibold), textColor: .label)
    
    private lazy var flagLabel = LabelFactory
        .createLabel(ofType: .cellLargeTitle(weight: .medium), textColor: .label)
    
    private let ratingView = RatingViewFactory.createRatingView(with: .airingToday)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SetupUI
    private func setupUI() {
        
        clipsToBounds = true
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingView)
        posterImageView.addSubview(flagLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(5)
            make.trailing.equalTo(posterImageView.snp.trailing)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(5)
            make.leading.equalTo(posterImageView.snp.leading)
            make.trailing.equalTo(ratingView.snp.leading).offset(-10)
        }
        
        flagLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    // MARK: Configure
    func configure(with cellItem: AiringTodayPresentation) {
        
        posterImageView.setImageWithKigfisher(with: cellItem.mainPoster)
        titleLabel.text = cellItem.title
        flagLabel.text = cellItem.flag
        ratingView.update(with: .init(ratingScore: cellItem.rating))
        
    }
}
