//
//  SplashViewController.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 01/03/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
class SplashViewController: UIViewController{
    private lazy var nameAppImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sleep(5)
        nextViewByHasLaunchedBefore()
    }
    
    func setViews(){
        view.backgroundColor = .black
        
        nameAppImage.image = R.image.banner_splash()
        nameAppImage.contentMode = .scaleAspectFill
        
    }
    
    func setConstraints() {
        view.addSubview(nameAppImage)
        
        nameAppImage.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 208, height: 38 ))
        }
        
    }
    
    func nextViewByHasLaunchedBefore(){
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: ConfigKey.hasLaunchedBefore)
        if hasLaunchedBefore {
            let tabBarController = TabBarEmailViewController()
            navigationController?.pushViewController(tabBarController, animated: true)
            
        }else {
            let view = OBViewController()
            navigationController?.pushViewController(view, animated: true)
            
        }
        
        
    }
    
    
}
