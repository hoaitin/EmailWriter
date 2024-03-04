//
//  ConfigFont.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 19/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit

struct FontName {
    static let name = "SF-Pro-Text"
}

extension UIFont {
    
    static  func appFont(weight: UIFont.Weight, size: CGFloat) -> UIFont {
                var fontName = ""
                switch weight {
                case .regular:
                    fontName = "\(FontName.name)-Regular"
                case .medium:
                    fontName = "\(FontName.name)-Medium"
                case .semibold:
                    fontName = "\(FontName.name)-Semibold"
                case .bold:
                    fontName = "\(FontName.name)-Bold"
                case .heavy:
                    fontName = "\(FontName.name)-Heavy"
                default:
                    fontName = "\(FontName.name)-Regular"
                }
                
                guard let customFont = UIFont(name: fontName, size: size) else {
                    // Fallback to system font if custom font is not available
                    return UIFont.systemFont(ofSize: size, weight: weight)
                }
                return customFont
    }
}

