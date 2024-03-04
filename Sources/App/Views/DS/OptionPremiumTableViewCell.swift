//
//  OptionPremiumTableViewCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 01/03/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
class OptionPremiumTableViewCell: UITableViewCell{
    static let id = "OptionPremiumTableViewCell"
    private lazy var optionImage = UIImageView()
    private lazy var namePremiumLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    private lazy var moneyLabel =  UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        optionImage.contentMode = .scaleAspectFill
        
        namePremiumLabel.textColor = .white
        namePremiumLabel.font = UIFont.appFont(weight: .bold, size: 16)
        
        descriptionLabel.textColor = ConfigColor.gray_text_app
        descriptionLabel.font = UIFont.appFont(weight: .semibold, size: 15)
        
        moneyLabel.textColor = .white
        moneyLabel.numberOfLines = 2
        moneyLabel.font = UIFont.appFont(weight: .medium, size: 15)
    }
    
    func setUpConstraints(){
        addSubview(optionImage)
        addSubview(namePremiumLabel)
        addSubview(descriptionLabel)
        addSubview(moneyLabel)
        
        optionImage.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 20, height: 20))
        }
        
      
    }
}
