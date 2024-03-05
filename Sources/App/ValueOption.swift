//
//  ValueOption.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 01/03/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation

struct ValueOption: Codable {
    let id: String
    var option: Option
    
    init(id: String, option: Option) {
        self.id = id
        self.option = option
    }
    
}
