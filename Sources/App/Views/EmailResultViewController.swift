//
//  EmailResultViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 29/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//


import Foundation
import UIKit
import SnapKit
import CoreLocation
import SafariServices
import MessageUI
import Toast_Swift
import GrowingTextView

class EmailResultViewController: BaseViewController {
    private lazy var navHeaderView = NavHeader()
    private lazy var contentView = UIView()
    private lazy var emailText = UITextView()
    private lazy var copyButton = UIButton()
    private lazy var shareButton = UIButton()
    private lazy var sendButton = UIButton()
    
    private var selectedIndexPath: IndexPath?
    
    override func setupViews() {
        super.setupViews()
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        view.backgroundColor = .black
        navHeaderView.setData(icon: "icon_right", text: "Email Result")
        navHeaderView.backButton.addTarget(self, action: #selector(nextBackView), for: .touchUpInside)
        
       
        emailText.text = "Dear [Boss's Name],\nI hope this email finds you well.I am writing to inform you about an urgent matter.After careful consideration and much thought, I have made the difficult decision to leave my position here at [Company Name].\nI want to express my gratitude for the opportunities and experiences I have had while working with such a remarkable team. Working with you and my colleagues has been an invaluable experience, and I am thankful for your guidance and support throughout my time here.\nI would greatly appreciate if we could schedule a meeting at your earliest convenience to discuss the next steps and any necessary arrangements. I am committed to working diligently during the notice period to ensure a seamless transition of my responsibilities.\nI want to reiterate my gratitude for the professional growth and invaluable experiences I have gained during my tenure here. I am confident that this decision will lead me to new opportunities for personal and career development.\nThank you once again for your understanding and support. I look forward to discussing this matter further with you.\nKind regards,\nNam [Last Name] \n Dear [Boss's Name],\nI hope this email finds you well.I am writing to inform you about an urgent matter.After careful consideration and much thought, I have made the difficult decision to leave my position here at [Company Name].\nI want to express my gratitude for the opportunities and experiences I have had while working with such a remarkable team. Working with you and my colleagues has been an invaluable experience, and I am thankful for your guidance and support throughout my time here.\nI would greatly appreciate if we could schedule a meeting at your earliest convenience to discuss the next steps and any necessary arrangements. I am committed to working diligently during the notice period to ensure a seamless transition of my responsibilities.\nI want to reiterate my gratitude for the professional growth and invaluable experiences I have gained during my tenure here. I am confident that this decision will lead me to new opportunities for personal and career development.\nThank you once again for your understanding and support. I look forward to discussing this matter further with you.\nKind regards,\nNam [Last Name]"
        emailText.isEditable = false
        emailText.textContainerInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        emailText.backgroundColor = ConfigColor.gray_tab
        emailText.textColor = .white
        emailText.font = UIFont.appFont(weight: .regular, size: 16)
        emailText.autocorrectionType = .no
        
        shareButton.layer.cornerRadius = 25
        shareButton.clipsToBounds = true
        shareButton.setTitle("Share", for: .normal)
        shareButton.titleLabel?.font = UIFont.appFont(weight: .medium, size: 16)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.setImage(R.image.pop_share(), for: .normal)
        shareButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        shareButton.backgroundColor = ConfigColor.main_bg
        shareButton.addTarget(self, action: #selector(handleShareText), for: .touchUpInside)
        
        copyButton.layer.cornerRadius = 25
        copyButton.clipsToBounds = true
        copyButton.setTitle("Copy", for: .normal)
        copyButton.titleLabel?.font = UIFont.appFont(weight: .medium, size: 16)
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.setImage(R.image.pop_copy(), for: .normal)
        copyButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        copyButton.backgroundColor = ConfigColor.main_bg
        copyButton.addTarget(self, action: #selector(handleCopyText), for: .touchUpInside)
        
        sendButton.layer.cornerRadius = 25
        sendButton.clipsToBounds = true
        sendButton.setTitle("Send", for: .normal)
        sendButton.titleLabel?.font = UIFont.appFont(weight: .medium, size: 18)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.setImage(R.image.icon_send_while(), for: .normal)
        sendButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        sendButton.backgroundColor = ConfigColor.green_main_app
        
  
    }
    
    func setUpConstraints() {
        view.addSubview(navHeaderView)
        view.addSubview(contentView)
        contentView.addSubview(emailText)
        view.addSubview(copyButton)
        view.addSubview(shareButton)
        view.addSubview(sendButton)
      
        navHeaderView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(47)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(40)
           
        }
        
        contentView.snp.makeConstraints{
            $0.top.equalTo(navHeaderView.snp.bottom)
            $0.bottom.equalTo(shareButton.snp.top).offset(-15)
            $0.leading.trailing.equalToSuperview()
        }
        
        emailText.snp.makeConstraints{
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        copyButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-64)
            $0.size.equalTo(CGSize(width: 87, height: 50))
        }
        
       shareButton.snp.makeConstraints{
           $0.leading.equalTo(copyButton.snp.trailing).offset(10)
           $0.trailing.equalTo(sendButton.snp.leading).offset(-10)
            $0.bottom.equalToSuperview().offset(-64)
           $0.height.equalTo(50)
        }
        
        sendButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-64)
            $0.size.equalTo(CGSize(width: 162, height: 50))
        }
        
        
        
    }
    
    
    @objc func nextBackView(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleCopyText(){
        guard let text = emailText.text, !text.isEmpty else {
               return
           }

           // Sao chép văn bản vào Pasteboard
           UIPasteboard.general.string = text
    }
    
    @objc func handleShareText(){
        guard let text = emailText.text, !text.isEmpty else {
               return
           }

           // Tạo một UIActivityViewController với văn bản là nội dung chia sẻ
           let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)

           // Hiển thị UIActivityViewController
           present(activityViewController, animated: true, completion: nil)
    }
    
}



