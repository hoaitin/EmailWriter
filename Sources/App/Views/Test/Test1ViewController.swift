//
//  Test1ViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 01/03/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
class Test1ViewController: UIViewController {
    private lazy var nextButton = UIButton()
    private lazy var titleLable = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpViews(){
        view.backgroundColor = .black
        
        nextButton.setTitle("next", for: .normal)
        nextButton.tintColor = .white
        
        
    }
    
    func setUpConstraints(){
        view.addSubview(titleLable)
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100, height: 40))
        }
    }
}
