//
//  HeaderViewCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 23/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//



import UIKit

class HeaderViewCell: UITableViewHeaderFooterView {
    static let id = "HeaderViewCell"
    public lazy var  nameLabel  = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(name: String){
        nameLabel.text = name
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews(){
        
        
        self.backgroundColor = .black
        
        nameLabel.font = UIFont.appFont(weight: .regular, size: 16)
        nameLabel.textColor = ConfigColor.main_setting2
        
    }
    
    func setUpConstraints(){
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.width.equalToSuperview()
            $0.height.equalTo(20)
        }
        
    }
    
}
