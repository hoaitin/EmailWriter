//
//  FooterVIew.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 26/01/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit

class FooterView: UIView {
    lazy var restorePurchaseButton = UIButton()
    lazy var termButton = UIButton()
    lazy var policeButton = UIButton()
    
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
        
        restorePurchaseButton.setTitle("Restore", for: .normal)
        restorePurchaseButton.setTitleColor(ConfigColor.gray_text_app, for: .normal)
        restorePurchaseButton.titleLabel?.font = UIFont.appFont(weight: .regular, size: 14)
        
        termButton.setTitle("Terms of User", for: .normal)
        termButton.setTitleColor( ConfigColor.gray_text_app, for: .normal)
        termButton.titleLabel?.font = UIFont.appFont(weight: .regular, size: 13)
        
        policeButton.setTitle("Privacy Police", for: .normal)
        policeButton.setTitleColor(ConfigColor.gray_text_app, for: .normal)
        policeButton.titleLabel?.font = UIFont.appFont(weight: .regular, size: 13)
     
    }
    
    func setUpConstraints(){
        addSubview(restorePurchaseButton)
        addSubview(termButton)
        addSubview(policeButton)
       
        termButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(CGSize(width: 120, height: 20))
        }
        
        restorePurchaseButton.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100, height: 20))
        }
        
        policeButton.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 120, height: 20))
        }
        
    }
    
    
    
}

