//
//  ProfileViewTableViewCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 27/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewTableViewCell: UITableViewCell {
    static let id = "ProfileViewTableViewCell"
    private lazy var userView = UserView()
    private lazy var createButton = UIButton()
    private lazy var editButton = UIButton()
 
    
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
        
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.titleLabel?.font = UIFont.appFont(weight: .medium, size: 15)
        createButton.backgroundColor  = ConfigColor.green_main_app
        createButton.layer.cornerRadius = 17.5
        createButton.isHidden = true
        
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.white, for: .normal)
        editButton.titleLabel?.font = UIFont.appFont(weight: .medium, size: 15)
        editButton.backgroundColor  = ConfigColor.green_main_app
        editButton.layer.cornerRadius = 17.5
    }
    
    func setUpConstraints(){
        addSubview(userView)
        addSubview(createButton)
        addSubview(editButton)
      
        userView.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(createButton.snp.leading)
            $0.height.equalTo(30)
        }
        
        createButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(CGSize(width: 80, height: 35))
        }
        
        editButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(CGSize(width: 80, height: 35))
        }
    }
    
    func setData(name: String, description: String){
        userView.setData(name: name, description: description)
    }
    
    
 
}
