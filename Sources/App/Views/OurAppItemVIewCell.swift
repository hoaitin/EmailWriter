//
//  OurAppItemVIewCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 27/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//


import Foundation
import UIKit

class OurAppItemVIewCell: UITableViewCell {
    static let id = "OurAppItemVIewCell"
    private lazy var iconImage = UIImageView()
    private lazy var nameAppLabel = UILabel()
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        contentView.backgroundColor = ConfigColor.black_bg_setting_app
        
        iconImage.contentMode = .scaleAspectFill
        iconImage.layer.cornerRadius = 10
        
        nameAppLabel.textColor = .white
        nameAppLabel.font = UIFont.appFont(weight: .medium, size: 15)
        
        
    }
    
    func setUpConstraints(){
        addSubview(iconImage)
        addSubview(nameAppLabel)
        
        iconImage.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        nameAppLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImage.snp.trailing).offset(12)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(18)
        }
        
    }
    
    func setData(icon: String, text: String){
        iconImage.image = UIImage(named: icon)
        nameAppLabel.text = text
    }
    
 
}

