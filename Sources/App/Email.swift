//
//  Email.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 22/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation


struct EmailSection: Codable {
    let id: String
    let name: String
    var data: [Email]
}


struct Email: Codable {
    let id: String
    var name: String
    var content: String
    let time: String
}
