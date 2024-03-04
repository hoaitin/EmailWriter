//
//  Configs.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 26/01/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit
import AppTrackingTransparency


struct Configs{
    
    
    static let isHasNortch: Bool = {
            let size = UIScreen.main.bounds.size
            return size.width / size.height < 375.0 / 667.0
        }()
    
    static func ATT () {
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                print("User has authorized tracking.")
            case .denied:
                print("User has denied tracking.")
            case .notDetermined:
                print("Tracking authorization dialog has not been shown yet.")
            case .restricted:
                print("Tracking is restricted.")
            @unknown default:
                print("Unknown tracking authorization status.")
            }
        }
    }
}



enum Onboarding: String {
    case onboarding_v1
    case onboarding_v2
}

enum Directstore: String {
    case directstore_ver1
    case directstore_ver2
}


