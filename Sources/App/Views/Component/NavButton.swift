//
//  NavButton.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 20/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//
import UIKit
class NavButton: UIButton {
   

//        var titleAlignment: NSTextAlignment = .center {
//            didSet {
//                titleLabel?.textAlignment = titleAlignment
//            }
//        }

        override func layoutSubviews() {
            super.layoutSubviews()
            
            guard let imageView = imageView else { return }
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -((imageView.bounds.width + 100 )), bottom: 0, right: 0)
           
        }
}
