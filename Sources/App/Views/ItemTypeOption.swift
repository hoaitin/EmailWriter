//
//  ItemTypeOption.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 23/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//


import Foundation
import UIKit
class ItemTypeOption: UIView {
    private lazy var iconContentImage = UIImageView()
    private lazy var contentLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setUpViews()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews(){
        
        iconContentImage.contentMode = .scaleAspectFill
        
        contentLabel.font = UIFont.appFont(weight: .medium, size: 12)
        contentLabel.textColor = ConfigColor.gray_char_app
       
    }
    
    func setUpConstraints(){
        addSubview(iconContentImage)
        addSubview(contentLabel)
        
        iconContentImage.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 10, height: 10))
        }
        
        contentLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconContentImage.snp.trailing).offset(3)
            $0.height.equalTo(14)
            $0.width.equalToSuperview().offset(-13)
        }
        
    }
    
    func setData(icon: String, text: String){
        iconContentImage.image = UIImage(named: icon)
        contentLabel.text = text
    }
}

