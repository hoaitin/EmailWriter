//
//  PopViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 21/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation

class PopViewController : UIViewController{
    private lazy var  popoverView = UIView()
    private lazy var  sendButton = NavButton()
    private lazy var  copyButton = NavButton()
    private lazy var  shareButton = NavButton()
    private lazy var  deleteButton = NavButton()
  
   //as
    override func viewDidLoad() {
      
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        view.backgroundColor = .black
        
        popoverView.backgroundColor =  ConfigColor.main_bg
        popoverView.layer.cornerRadius = 15
        popoverView.clipsToBounds = true
        
        sendButton.setTitle("Send", for: .normal)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        sendButton.setTitleColor(ConfigColor.mainTabbar, for: .normal)
        sendButton.setImage(UIImage(named: "pop_send"), for: .normal)
        sendButton.backgroundColor = ConfigColor.gray_tab
        
        copyButton.setTitle("Copy", for: .normal)
        copyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        copyButton.setTitleColor(UIColor.white, for: .normal)
        copyButton.setImage(UIImage(named: "pop_copy"), for: .normal)
        copyButton.backgroundColor = ConfigColor.gray_tab
        
        shareButton.setTitle("Share", for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.setImage(UIImage(named: "pop_share"), for: .normal)
        shareButton.backgroundColor = ConfigColor.gray_tab
        
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        deleteButton.setTitleColor(ConfigColor.red_text_delete, for: .normal)
        deleteButton.setImage(UIImage(named: "pop_delete"), for: .normal)
        deleteButton.backgroundColor = ConfigColor.gray_tab
        
    }
 
    func setUpConstraints() {
        view.addSubview(popoverView)
        popoverView.addSubview(sendButton)
        popoverView.addSubview(copyButton)
        popoverView.addSubview(shareButton)
        popoverView.addSubview(deleteButton)
        
        popoverView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.size.equalTo(CGSize(width: 184, height: 163))
        }
        
        sendButton.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        copyButton.snp.makeConstraints{
            $0.top.equalTo(sendButton.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        shareButton.snp.makeConstraints{
            $0.top.equalTo(copyButton.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        deleteButton.snp.makeConstraints{
            $0.top.equalTo(shareButton.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        
    }
    
   
    
   

}


