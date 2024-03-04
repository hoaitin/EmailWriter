//
//  AboutTableViewCell.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 27/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit

class AboutTableViewCell: UITableViewCell {
    static let id = "AboutTableViewCell"
    public lazy var itemView = AboutITemView()
 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(icon: String , text: String){
        itemView.setData(icon: icon , text: text)
    }
    
    func setUpViews(){
        contentView.backgroundColor = ConfigColor.black_bg_setting_app
        
    }
    
    func setUpConstraints(){
        contentView.addSubview(itemView)
        
        itemView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    
    }
    
 
}
