//
//  SearchViewCell.swift
//  GitHubJobSearch
//
//  Created by Eugene Berezin on 12/14/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewCell: UICollectionViewCell {
    
    var jobResult: Result! {
        didSet {
            companyleLabel.text = jobResult.company
            titleLabel.text = jobResult.title
            typeLabel.text = jobResult.type
            locationLabel.text = jobResult.location
            guard let url = URL(string: jobResult.company_logo ?? "") else { return }
            logoImageView.sd_setImage(with: url)
        }
    }
    
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 12
        iv.contentMode = .scaleAspectFit
        return iv
    }() //AspectFitImageView(image: UIImage(named: "logo"), cornerRadius: 12)
    
    let companyleLabel: UILabel = {
        let label = UILabel()
        label.text = "Awesome Company"
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    let titleLabel: UILabel = {
         let label = UILabel()
         label.text = "iOS developer"
         label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .label
         return label
     }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Full time"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    let urlLabel: UILabel = {
         let label = UILabel()
         label.text = "https://eugene-berezin-iosdev.com/"
        label.numberOfLines = 0
         label.font = .systemFont(ofSize: 16)
         return label
     }()
    
    let locationLabel: UILabel = {
         let label = UILabel()
         label.text = "Seattle, WA"
         label.font = .systemFont(ofSize: 16)
        label.textColor = .label
         return label
     }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(logoImageView)
        logoImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10), size: .init(width: 80, height: 100))
        let stackView = UIStackView(arrangedSubviews: [companyleLabel, titleLabel, typeLabel, locationLabel
        ])
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: logoImageView.leadingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        stackView.axis = .vertical
        stackView.spacing = 10
        //stackView.distribution = .fillEqually
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
