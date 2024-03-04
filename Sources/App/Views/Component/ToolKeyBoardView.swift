//
//  ToolKeyBoardView.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 26/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import UIKit
import GrowingTextView
class ToolKeyBoardView: UIView {
    private lazy var typeText = GrowingTextView()
    private lazy var doneButton = UIButton()
    private lazy var generateButton = UIButton()


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
        typeText.placeholder = "Type anything..."
        typeText.font = UIFont.appFont(weight: .regular, size: 14)
        typeText.textColor = .white
        typeText.backgroundColor = .black
        typeText.trimWhiteSpaceWhenEndEditing = true
        typeText.autocorrectionType = .no
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.titleLabel?.font = UIFont.appFont(weight: .bold, size: 13)
        doneButton.backgroundColor = ConfigColor.gray_tab
        doneButton.layer.cornerRadius = 17.5
        
        generateButton.setTitle("Generate", for: .normal)
        generateButton.setTitleColor(.white, for: .normal)
        generateButton.titleLabel?.font = UIFont.appFont(weight: .bold, size: 13)
        generateButton.backgroundColor = ConfigColor.green_main_app
        generateButton.layer.cornerRadius = 17.5
        
    }
    
    private func setConstraints(){
        addSubview(typeText)
        addSubview(doneButton)
        addSubview(generateButton)
        
        typeText.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(doneButton.snp.leading).offset(-10)
            $0.height.equalTo(40)
        }
        
        generateButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 90, height: 35))
        }
        
        doneButton.snp.makeConstraints{
            $0.trailing.equalTo(generateButton.snp.leading).inset(-10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 58, height: 35))
        }
        
    }

}

