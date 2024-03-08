//
//  WritingOptionView.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 23/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
class WritingOptionView: UIView {
    private lazy var headerLabel = UILabel()
    private lazy var iconContentImage = UILabel()
    private lazy var contentLabel = UILabel()
    private lazy var onOffItemView = ItemTypeOption()
    private lazy var typeItemView = ItemTypeOption()
    private lazy var lengthItemView = ItemTypeOption()
    private lazy var toneItemView = ItemTypeOption()
    private lazy var emojiItemView = ItemTypeOption()
    public lazy var selectTypeButton = UIButton()
    
    
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
        
        headerLabel.text = "Writing Options"
        headerLabel.textColor = .white
        headerLabel.font = UIFont.appFont(weight: .medium, size: 16)
        
        contentLabel.font = UIFont.appFont(weight: .medium, size: 12)
        contentLabel.textColor = ConfigColor.gray_text_app
       
        
        selectTypeButton.setImage(R.image.icon_write_top(), for: .normal)
        selectTypeButton.contentMode = .scaleAspectFill
       
        
    }
    
    func setData(itemLag: Option, itemType: Option, itemLength: Option, itemTone: Option, itemEmoji: Option){
        iconContentImage.text = itemLag.image
        contentLabel.text = itemLag.name
        onOffItemView.setData(icon: "icon_on_off", text: "On/Off")
        typeItemView.setData(icon: itemType.image, text: itemType.name)
        lengthItemView.setData(icon: itemLength.image, text: itemLength.name)
        toneItemView.setData(icon: itemTone.image, text: itemTone.name)
        emojiItemView.setData(icon: itemEmoji.image, text: itemEmoji.name)
    }
    
    func setUpConstraints(){
        addSubview(headerLabel)
        addSubview(iconContentImage)
        addSubview(contentLabel)
        addSubview(onOffItemView)
        addSubview(typeItemView)
        addSubview(lengthItemView)
        addSubview(toneItemView)
        addSubview(emojiItemView)
        addSubview(selectTypeButton)
        
        headerLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(16)
            $0.size.equalTo(CGSize(width: 130, height: 20))
        }
        
        iconContentImage.snp.makeConstraints{
            $0.top.equalTo(headerLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(16)
            $0.size.equalTo(CGSize(width: 12, height: 12))
        }
        
        contentLabel.snp.makeConstraints{
            $0.top.equalTo(headerLabel.snp.bottom).offset(5)
            $0.leading.equalTo(iconContentImage.snp.trailing).offset(5)
            $0.height.equalTo(14)
            $0.width.equalTo(200)
        }
        
        onOffItemView.snp.makeConstraints{
            $0.left.equalToSuperview().offset(16)
            $0.top.equalTo(contentLabel.snp.bottom).offset(5)
            $0.height.equalTo(14)
        }
        
        typeItemView.snp.makeConstraints{
            $0.leading.equalTo(onOffItemView.snp.trailing).offset(7)
            $0.top.equalTo(contentLabel.snp.bottom).offset(5)
            $0.height.equalTo(14)
            
        }
        
        lengthItemView.snp.makeConstraints{
            $0.leading.equalTo(typeItemView.snp.trailing).offset(7)
            $0.top.equalTo(contentLabel.snp.bottom).offset(5)
            $0.height.equalTo(14)
            
        }
        
        toneItemView.snp.makeConstraints{
            $0.leading.equalTo(lengthItemView.snp.trailing).offset(7)
            $0.top.equalTo(contentLabel.snp.bottom).offset(5)
            $0.height.equalTo(14)
            
        }
        
        emojiItemView.snp.makeConstraints{
            $0.leading.equalTo(toneItemView.snp.trailing).offset(7)
            $0.top.equalTo(contentLabel.snp.bottom).offset(5)
            $0.height.equalTo(14)
            
        }
        
        selectTypeButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.size.equalTo(CGSize(width: 15, height: 15))
        }
    
    }
    
    func setData(icon: String, text: String){
       
    }
}
