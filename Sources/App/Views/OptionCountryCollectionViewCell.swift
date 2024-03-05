//
//  OptionCountryCollectionViewCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 05/03/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import UIKit
import Kingfisher

class OptionCountryCollectionViewCell: UICollectionViewCell {
    static let id = "OptionCountryCollectionViewCell"
    private lazy var iconImage = UILabel()
    private lazy var nameLabel = UILabel()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
        setUpConstraints()
        
    }
    
    func setUpView(){
        contentView.backgroundColor = ConfigColor.gray_tab
        contentView.layer.cornerRadius = 17.5
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(hex: 0x0FBF89).cgColor
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont.appFont(weight: .medium, size: 14)
        
    }
    
    func setUpConstraints(){
        
        contentView.addSubview(iconImage)
        contentView.addSubview(nameLabel)
        
        iconImage.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(12)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        nameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImage.snp.trailing).offset(7)
            $0.trailing.equalToSuperview()
        }
        
        
    }
    
    func setData(icon: String , name: String){
        iconImage.text = icon
        nameLabel.text = name
     
    }
    

    
}
