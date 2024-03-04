//
//  UserView.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 27/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
class UserView: UIView {
    private lazy var iconUserImage = UIImageView()
    private lazy var nameUserLabel = UILabel()
    private lazy var descriptionUserLabel = UILabel()
    
    
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
        iconUserImage.image = R.image.icon_options_user()
        iconUserImage.contentMode = .scaleAspectFill
        
        nameUserLabel.font = UIFont.appFont(weight: .regular, size: 15)
        nameUserLabel.textColor = .white
        
        descriptionUserLabel.font = UIFont.appFont(weight: .regular, size: 12)
        descriptionUserLabel.textColor = ConfigColor.gray_text_app
        
        
    }
    
    private func setConstraints(){
        addSubview(iconUserImage)
        addSubview(nameUserLabel)
        addSubview(descriptionUserLabel)
        
        
        iconUserImage.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.size.equalTo(CGSize(width: 35, height: 35))
        }
        
        nameUserLabel.snp.makeConstraints{
            $0.leading.equalTo(iconUserImage.snp.trailing).offset(12)
            $0.top.equalToSuperview()
            $0.height.equalTo(18)
        }
        
        descriptionUserLabel.snp.makeConstraints{
            $0.leading.equalTo(iconUserImage.snp.trailing).offset(12)
            $0.top.equalTo(nameUserLabel.snp.bottom).offset(2)
            $0.height.equalTo(15)
        }
        
    }
    
    func setData(name: String, description: String) {
        nameUserLabel.text = name
        descriptionUserLabel.text = description
    }
}
