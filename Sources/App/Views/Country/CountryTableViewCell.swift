//
//  LagTableViewCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 29/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    static let id = "CountryTableViewCell"
    private lazy var titleLabel = UILabel()
    private lazy var iconLabel = UILabel()
    private lazy var iconCheckImage = UIImageView()
    
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(name: String,icon: String){
        titleLabel.text = name
        iconLabel.text = icon
    }
    
    func setUpViews(){
        contentView.backgroundColor = .black

        titleLabel.textColor = ConfigColor.gray_text_app
        titleLabel.font = UIFont.appFont(weight: .medium, size: 18)
        
        iconCheckImage.image = R.image.icon_check_lag()
        iconCheckImage.contentMode = .scaleAspectFill
        iconCheckImage.isHidden = true
       
    }
    
    func setUpConstraints(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(iconLabel)
        contentView.addSubview(iconCheckImage)
       
        iconLabel.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 18, height: 18))
        }
        
         titleLabel.snp.makeConstraints{
             $0.leading.equalTo(iconLabel.snp.trailing).offset(5)
             $0.centerY.equalToSuperview()
             $0.height.equalTo(18)
         }
        
        iconCheckImage.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
    
    func setAction(){
        iconCheckImage.isHidden = false
    }
    
    func hiddenAction(){
        iconCheckImage.isHidden = true
    }
    
   
}



