//
//  HeaderCell.swift
//  GitHubJobSearch
//
//  Created by Eugene Berezin on 12/14/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    let positionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Filter by title, companies, experience.."
        return textField
    }()
    
    let cityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder  = "Filter by city... "
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Search", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [positionTextField, cityTextField, searchButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 20, bottom: 10, right: 20))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
