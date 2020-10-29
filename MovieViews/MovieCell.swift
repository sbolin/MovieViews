//
//  MovieCell.swift
//  MovieViews
//
//  Created by Scott Bolin on 10/20/20.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let reuseIdentifier = "movie-cell-reuse-identifier"
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let yearLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension MovieCell {
    func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(yearLabel)
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel.adjustsFontForContentSizeCategory = true
        
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.textColor = .placeholderText
        
        yearLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        yearLabel.adjustsFontForContentSizeCategory = true
        yearLabel.textColor = .secondaryLabel
        
        imageView.layer.borderColor = UIColor.systemIndigo.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.5)
        
        let spacing = CGFloat(10)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
 //           titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 280),


            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            descriptionLabel.widthAnchor.constraint(equalToConstant: 100),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            
            yearLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -14),
//            yearLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 6),
            yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            yearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
//            yearLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
//            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            yearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            

        ])
    }
}
