//
//  TypeOptions.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 26/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation


struct Option: Codable {
    let id: String
    var name: String
    var image: String
    
}

struct TypeOptions: Codable {
    let id: String
    var name: String
    var icon: String
    var data: [Option]
}
