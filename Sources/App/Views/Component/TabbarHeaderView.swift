//
//  TabbarHeaderView.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 04/03/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
import PanModal
class TabbarHeaderView: UIView {
    private lazy var titleLabel = UILabel()
    public lazy var rightButton = UIButton()

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
        titleLabel.text = "Em@il Write"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.appFont(weight: .bold, size: 20)
        
        rightButton.layer.cornerRadius = 20
        rightButton.clipsToBounds = true
        rightButton.setTitle("Upgrade", for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        rightButton.setTitleColor(UIColor(hex: 0xFFDC6D), for: .normal)
        rightButton.setImage(UIImage(named: "icon_tool_translate"), for: .normal)
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        // Đặt hình ảnh và tiêu đề cho UIButton
        rightButton.backgroundColor = UIColor(hex: 0xFFDF80 , alpha: 0.2) // Màu nền của UIButton
                
        
    }
    
    private func setConstraints(){
        addSubview(titleLabel)
        addSubview(rightButton)
        
        
        titleLabel.snp.makeConstraints{
        $0.top.equalToSuperview()
        $0.left.equalToSuperview().offset(20)
        $0.size.equalTo(CGSize(width: 140, height: 20))
        }
        
        rightButton.snp.makeConstraints{
         $0.top.equalToSuperview()
         $0.right.equalToSuperview().offset(-20)
         $0.size.equalTo(CGSize(width: 106, height: 40))
        }
        
    }
    


}
