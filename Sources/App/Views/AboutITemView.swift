//
//  AboutITemView.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 27/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
class AboutITemView: UIView {
    private lazy var iconImage = UIImageView()
    private lazy var textLabel =  UILabel()
    
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
        iconImage.contentMode = .scaleAspectFill
        
        textLabel.textColor = .white
        textLabel.font = UIFont.appFont(weight: .medium, size: 15)
    
    }
    
    func setUpConstraints(){
        addSubview(iconImage)
        addSubview(textLabel)
        
        iconImage.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        textLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImage.snp.trailing).offset(12)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(18)
        }
        
    }
    
    func setData(icon: String, text: String){
        iconImage.image = UIImage(named: icon)
        textLabel.text = text
    }
}
