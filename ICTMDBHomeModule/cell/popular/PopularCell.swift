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
    
    private let posterBGContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel = LabelFactory
        .createLabel(ofType: .cellLargeTitle(weight: .semibold), textColor: .white)
    private lazy var dateLabel = LabelFactory
        .createLabel(ofType: .cellMedium(weight: .medium), textColor: .white)
    private lazy var ratingView = RatingViewFactory
        .createRatingView(with: .popular)
    private lazy var flagLabel = LabelFactory
        .createLabel(ofType: .cellLargeTitle(weight: .semibold), textColor: .white)
    private lazy var infoLabel = LabelFactory
        .createLabel(ofType: .cellSmall(weight: .regular), textColor: .white)
    private let posterBGImageView = ImageViewFactory.createImageView(ofType: .background)
    private let mainPoster = ImageViewFactory.createImageView(ofType: .main)
    private let posterBGBlurView = BlurFactory.createBlurView(ofType: .dark)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
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
    func configure(with cellItem: PopularTVShowPresentation) {
        mainPoster.setImageWithKigfisher(with: cellItem.mainPoster)
        posterBGImageView.setImageWithKigfisher(with: cellItem.backdropPoster)
        nameLabel.text = cellItem.title
        dateLabel.text = cellItem.year
        ratingView.update(with: .init(ratingScore: cellItem.rating))
        flagLabel.text = cellItem.flag
        infoLabel.text = cellItem.info
    }
    
    //MARK: ConfigureUI
    func configureUI() {
        contentView.addSubview(posterBGContainerView)
        posterBGContainerView.addSubview(posterBGImageView)
        posterBGContainerView.addSubview(posterBGBlurView)
        posterBGContainerView.addSubview(mainPoster)
        posterBGContainerView.addSubview(nameLabel)
        posterBGContainerView.addSubview(dateLabel)
        posterBGContainerView.addSubview(ratingView)
        mainPoster.addSubview(flagLabel)
        
        posterBGContainerView.addSubview(infoLabel)
        posterBGContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        posterBGImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        posterBGBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainPoster.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(1.0/3.0)
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.bottom.equalTo(nameLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainPoster.snp.top)
            make.leading.equalTo(mainPoster.snp.trailing).offset(10)
            make.trailing.equalTo(ratingView.snp.leading).offset(-5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(mainPoster.snp.trailing).offset(10)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.leading.equalTo(mainPoster.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        flagLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
    
    
}
