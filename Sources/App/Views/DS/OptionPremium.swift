//
//  OptionPremium.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 01/03/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//



import Foundation
import UIKit
class OptionPremium: UIView {
     lazy var optionButton = UIButton()
    private lazy var boderTopView = UIView()
    private lazy var namePremiumLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    private lazy var moneyLabel =  UILabel()
    private lazy var boderBottomView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        namePremiumLabel.textColor = .white
        namePremiumLabel.font = UIFont.appFont(weight: .bold, size: 16)
        
        descriptionLabel.textColor = ConfigColor.gray_text_app
        descriptionLabel.font = UIFont.appFont(weight: .semibold, size: 15)
        
        moneyLabel.textColor = .white
        moneyLabel.numberOfLines = 2
        moneyLabel.font = UIFont.appFont(weight: .medium, size: 15)
        
        boderTopView.backgroundColor = ConfigColor.main_bg
        boderBottomView.backgroundColor = ConfigColor.main_bg
        
    }
    
    private func setConstraints(){
        addSubview(optionButton)
        addSubview(namePremiumLabel)
        addSubview(descriptionLabel)
        addSubview(moneyLabel)
        addSubview(boderTopView)
        addSubview(boderBottomView)
        
        
        optionButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        namePremiumLabel.snp.makeConstraints{
            $0.leading.equalTo(optionButton.snp.trailing).offset(15)
            $0.top.equalToSuperview().offset(16.5)
            $0.size.equalTo(CGSize(width: 200, height: 19))
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.leading.equalTo(optionButton.snp.trailing).offset(15)
            $0.bottom.equalToSuperview().offset(-16.5)
            $0.size.equalTo(CGSize(width: 200, height: 18))
        }
        
        moneyLabel.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 70, height: 50))
        }
        
        boderTopView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalToSuperview()
        }
        
        boderBottomView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func setData(name: String, description: String, money: String, isYear: Bool) {
        namePremiumLabel.text = name
        descriptionLabel.text = description
        moneyLabel.text = money
        
        if isYear{
            
            let attributedText = NSMutableAttributedString(string: name)
            // Đặt kích thước và độ đậm chữ cho phần đầu của văn bản
            let font1 = UIFont.appFont(weight: .bold, size: 16)
            let attributes1: [NSAttributedString.Key: Any] = [
                .font: font1,
                .foregroundColor: UIColor.white
            ]
            attributedText.addAttributes(attributes1, range: NSRange(location: 0, length: 6))
            // Đặt kích thước và độ đậm chữ cho phần cuối của văn bản
            let font2 = UIFont.appFont(weight: .bold, size: 12)
            let attributes2: [NSAttributedString.Key: Any] = [
                .font: font2,
                .foregroundColor: ConfigColor.green_main_app
            ]
            attributedText.addAttributes(attributes2, range: NSRange(location: 6, length: name.count - 6))
            // Tạo một UILabel và thiết lập attributedText
            namePremiumLabel.attributedText = attributedText
        } else {
            boderTopView.isHidden = true
        }
        
    }
    
    func checkOption(){
        optionButton.setImage(R.image.icon_pick_enable(), for: .normal)
        
    }
    
    func hiddenCheckOption(){
        optionButton.setImage(R.image.icon_pick_disable(), for: .normal)
    }
}

