//
//  FormInputView.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 27/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
class FormInputView: UIView {
    private lazy var titleLabel = UILabel()
    lazy var inputTextField = UITextField()


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
        titleLabel.textColor = .white
        titleLabel.font = UIFont.appFont(weight: .medium, size: 15)
    
        inputTextField.backgroundColor = ConfigColor.gray_tab
        inputTextField.layer.cornerRadius = 10
        inputTextField.textColor = .white
        inputTextField.font = UIFont.appFont(weight: .regular, size: 14)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: ConfigColor.gray_text_app // Thay UIColor.red bằng màu bạn muốn
               ]
        let attributedPlaceholder = NSAttributedString(string: "Placeholder Text", attributes: attributes)
               
               // Thiết lập attributedPlaceholder cho UITextField
        inputTextField.attributedPlaceholder = attributedPlaceholder
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: inputTextField.frame.height))
        inputTextField.leftView = paddingView
        inputTextField.leftViewMode = .always
        
    }
    
    private func setConstraints(){
        addSubview(titleLabel)
        addSubview(inputTextField)
        
        titleLabel.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(18)
        }
        
        inputTextField.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.height.equalTo(40)
        }
      
        
    }
    
     func setData(name: String, inputPlaceholder : String){
        inputTextField.placeholder = inputPlaceholder
        titleLabel.text = name
    }
}
