//
//  DSViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 27/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
class DSViewController:UIViewController {
    private lazy var premiumButton = UIButton()
    private lazy var closeButton = UIButton()
    private lazy var premiumLabel = UILabel()
    private lazy var premiumImage = UIImageView()
    
    private lazy var aboutView = FooterView()
    private lazy var contineuButton = UIButton()
    private lazy var descriptionTextLabel = UILabel()
    private lazy var optionYearly = OptionPremium()
    private lazy var optionWeekly = OptionPremium()
    
    var userDeffaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
    }
    
    var option = 0
    
    func setViews(){
        view.backgroundColor = .black
        
        premiumButton.setTitle("PREMIUM", for: .normal)
        premiumButton.setTitleColor(ConfigColor.yellow_text_app, for: .normal)
        premiumButton.titleLabel?.font = UIFont.appFont(weight: .bold, size: 14)
        premiumButton.backgroundColor = ConfigColor.yellow_bg_app
        premiumButton.layer.cornerRadius = 17.5
        
        closeButton.setImage(R.image.icon_three_dots(), for: .normal)
        closeButton.addTarget(self, action: #selector(handleCloseView), for: .touchUpInside)
        
        premiumLabel.text = "Become Premium"
        premiumLabel.textColor = .white
        premiumLabel.font = UIFont.appFont(weight: .bold, size: 20)
        
        premiumImage.image = R.image.image_premium()
        premiumImage.contentMode = .scaleAspectFill
        
        contineuButton.setTitle("Continue with Yearly Plan", for: .normal)
        contineuButton.setTitleColor(ConfigColor.yellow_text_app, for: .normal)
        contineuButton.titleLabel?.font = UIFont.appFont(weight: .semibold, size: 18)
        contineuButton.backgroundColor = ConfigColor.yellow_bg_app
        contineuButton.layer.cornerRadius = 15
        
        descriptionTextLabel.text = "BILLED YEARLY · CANCEL ANYTIME"
        descriptionTextLabel.textColor = ConfigColor.gray_text_app
        descriptionTextLabel.font = UIFont.appFont(weight: .semibold, size: 12)
        descriptionTextLabel.textAlignment = .center
        
        optionYearly.setData(name: "Yearly save 70%", description: "29.99$ / year", money: "0.65$ per week", isYear: true)
        optionYearly.checkOption()
        optionYearly.optionButton.addTarget(self, action: #selector(checkOptionYearly), for: .touchUpInside)
        
        optionWeekly.setData(name: "Weekly Trial", description: "3 days free trial", money: "0.65$ per week", isYear: false)
        optionWeekly.hiddenCheckOption()
        optionWeekly.optionButton.addTarget(self, action: #selector(checkOptionWeekly), for: .touchUpInside)
    }
    
    func setConstraints(){
        view.addSubview(premiumButton)
        view.addSubview(closeButton)
        view.addSubview(premiumLabel)
        view.addSubview(premiumImage)
        
        view.addSubview(descriptionTextLabel)
        view.addSubview(contineuButton)
        view.addSubview(aboutView)
        view.addSubview(optionYearly)
        view.addSubview(optionWeekly)
        
        
        premiumButton.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(51.5)
            $0.size.equalTo(CGSize(width: 100, height: 35))
        }
        
        closeButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(49)
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        premiumLabel.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.top.equalTo(premiumButton.snp.bottom).offset(29)
            $0.height.equalTo(33)
        }
        
        premiumImage.snp.makeConstraints{
            $0.top.equalTo(premiumLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(220)
        }
        
        descriptionTextLabel.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(contineuButton.snp.top).offset(-10)
            $0.height.equalTo(14)
        }
        
        contineuButton.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(aboutView.snp.top).offset(-25)
            $0.height.equalTo(60)
        }
        
        aboutView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-44)
            $0.size.equalTo(CGSize(width: 320, height: 20))
        }
        
        optionYearly.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(premiumImage.snp.bottom).offset(40)
            $0.height.equalTo(77)
        }
        
        optionWeekly.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.top.equalTo(optionYearly.snp.bottom)
            $0.height.equalTo(77)
        }

    }
    
    
    @objc func handleCloseView(){
        let hasLaunchedBefore = userDeffaults.bool(forKey: ConfigKey.hasLaunchedBefore)

        if hasLaunchedBefore {
            dismiss(animated: true, completion: nil)
        }else {
            userDeffaults.setValue(true, forKey: ConfigKey.hasLaunchedBefore)
            let tabbar = TabBarViewController()
            navigationController?.pushViewController(tabbar, animated: true)
        }
        
    }
    
    @objc func checkOptionYearly(){
        option =  0
        optionYearly.checkOption()
        optionWeekly.hiddenCheckOption()
    }
    
    @objc func checkOptionWeekly(){
        
        option = 1
        optionYearly.hiddenCheckOption()
        optionWeekly.checkOption()
    }
}
