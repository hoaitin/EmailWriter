//
//  ProfileViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 27/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
import PanModal
import GrowingTextView

class ProfileViewController: UIViewController {
    private lazy var dragIndicator = UIView()
    private lazy var headerLabel = UILabel()
    private lazy var nameInputView = FormInputView()
    private lazy var genderInputView = FormInputView()
    private lazy var ageInputView = FormInputView()
    private lazy var roleInputView = FormInputView()
    private lazy var yourInterestsLabel = UILabel()
    private lazy var yourInterestsView = UIView()
    private lazy var yourInterestsText = GrowingTextView()
    
    
    private lazy var writeButtonView = UIView()
    private lazy var iconTranslateWriteButton = UIImageView()
    private lazy var iconCheckWriteButton = UIImageView()
    private lazy var titleWriteButtonLabel = UILabel()
    private lazy var writeButton = UIButton()
   
    override func viewDidLoad() {
        
        setUpViews()
        setUpConstraints()
        
    }
        
    func setUpViews() {
        view.backgroundColor = .black
        
        dragIndicator.backgroundColor =  ConfigColor.gray_tab
        dragIndicator.layer.cornerRadius = 2.5
        
        headerLabel.text = "Your Profile"
        headerLabel.textColor = .white
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.appFont(weight: .medium, size: 16)
        
        nameInputView.setData(name: "Name", inputPlaceholder: "Liam")
        
        genderInputView.setData(name: "Gender", inputPlaceholder: "Male / Female / etc")
        
        ageInputView.setData(name: "Age", inputPlaceholder: "30")
        
        roleInputView.setData(name: "Profession / Role", inputPlaceholder: "CEO / Student / Developer")
        
        writeButton.backgroundColor = ConfigColor.green_main_app
        writeButton.layer.cornerRadius = 25
        
        titleWriteButtonLabel.text = "Write"
        titleWriteButtonLabel.textColor = .white
        titleWriteButtonLabel.font = UIFont.appFont(weight: .medium, size: 18)
        
        iconTranslateWriteButton.image = R.image.icon_tool_translate()
        
        iconCheckWriteButton.image = R.image.icon_check_write()
       
        yourInterestsLabel.text = "Your iterests"
        yourInterestsLabel.textColor = .white
        yourInterestsLabel.backgroundColor = .black
        yourInterestsLabel.font = UIFont.appFont(weight: .medium, size: 15)

        
        yourInterestsText.placeholder = "I enjoys coding, problem-solving, staying updated with tech trends, collaborating with teams, and continuously learning to enhance skills and create innovative solutions."
        yourInterestsText.trimWhiteSpaceWhenEndEditing = true
        yourInterestsText.placeholderColor = ConfigColor.gray_text_app
        yourInterestsText.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        yourInterestsText.backgroundColor = ConfigColor.gray_tab
        yourInterestsText.layer.cornerRadius = 10
        yourInterestsText.textColor = .white
        yourInterestsText.font = UIFont.appFont(weight: .regular, size: 14)
        yourInterestsText.autocorrectionType = .no
        
    }
        
    func setUpConstraints() {
        view.addSubview(dragIndicator)
        view.addSubview(headerLabel)
        view.addSubview(nameInputView)
        view.addSubview(genderInputView)
        view.addSubview(ageInputView)
        view.addSubview(roleInputView)
        
        view.addSubview(yourInterestsView)
        yourInterestsView.addSubview(yourInterestsLabel)
        yourInterestsView.addSubview(yourInterestsText)
        
        view.addSubview(writeButton)
        writeButton.addSubview(writeButtonView)
        writeButtonView.addSubview(iconTranslateWriteButton)
        writeButtonView.addSubview(iconCheckWriteButton)
        writeButtonView.addSubview(titleWriteButtonLabel)
        
       
        dragIndicator.snp.makeConstraints{
            $0.top.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 80, height: 5))
        }
        
        headerLabel.snp.makeConstraints{
            $0.top.equalTo(dragIndicator.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        nameInputView.snp.makeConstraints{
            $0.top.equalTo(headerLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(70)
        }
        
        genderInputView.snp.makeConstraints{
            $0.top.equalTo(nameInputView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(70)
        }
        
        ageInputView.snp.makeConstraints{
            $0.top.equalTo(genderInputView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(70)
        }
        
        roleInputView.snp.makeConstraints{
            $0.top.equalTo(ageInputView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(70)
        }
        
        yourInterestsView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(roleInputView.snp.bottom).offset(20)
            $0.bottom.equalTo(writeButton.snp.top).offset(-20)
        }
        
        yourInterestsLabel.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(17)
        }
        
        yourInterestsText.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(yourInterestsLabel.snp.bottom).offset(12)
        }
       
        writeButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(79)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 200, height: 50))
        }
        
        writeButtonView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100, height: 20))
        }
        
        iconTranslateWriteButton.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.size.equalTo(CGSize(width: 20, height: 20))
            $0.bottom.top.equalToSuperview()
        }
        
        iconCheckWriteButton.snp.makeConstraints{
            $0.leading.equalTo(iconTranslateWriteButton.snp.trailing).offset(7)
            $0.size.equalTo(CGSize(width: 20, height: 20))
            $0.bottom.top.equalToSuperview()
        }
      
        titleWriteButtonLabel.snp.makeConstraints{
            $0.leading.equalTo(iconCheckWriteButton.snp.trailing).offset(7)
            $0.bottom.top.equalToSuperview()
        }
        
       
        
    }
    
}

extension ProfileViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil // Trả về UIScrollView nếu bạn muốn cho phép cuộn khi modal mở rộng
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(view.frame.height - 50) // Chiều cao của modal khi ở trạng thái short
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(20) // Chiều cao tối đa của modal khi ở trạng thái long
    }
    
    var showDragIndicator: Bool {
        return false
    }
   
}