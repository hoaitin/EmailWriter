//
//  RequestApi.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 11/01/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation

class RequestApi{
    static var share: RequestApi = RequestApi()

    
    func getFileJsonEmail() -> [EmailSection]? {
        guard let path = Bundle.main.path(forResource: "MyEmail", ofType: "json") else {
            // Không tìm thấy tệp "emails.json" trong bundle của ứng dụng
            print("Error: Could not find file 'emails.json'")
            return nil
        }

        do {
            let url = URL(fileURLWithPath: path)
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let emailList = try decoder.decode([EmailSection].self, from: jsonData)
            return emailList
        } catch {
            // Xử lý lỗi một cách nghiêm túc hơn
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    
    
    func getFileJsonTypeOptions() -> [TypeOptions]? {
        guard let path = Bundle.main.path(forResource: "typeOptions", ofType: "json") else {
            // Không tìm thấy tệp "emails.json" trong bundle của ứng dụng
            print("Error: Could not find file 'emails.json'")
            return nil
        }

        do {
            let url = URL(fileURLWithPath: path)
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let data = try decoder.decode([TypeOptions].self, from: jsonData)
            return data
        } catch {
            // Xử lý lỗi một cách nghiêm túc hơn
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    func getFileJsonCountry() -> [Country]? {
        guard let path = Bundle.main.path(forResource: "country", ofType: "json") else {
            // Không tìm thấy tệp "emails.json" trong bundle của ứng dụng
            print("Error: Could not find file 'country.json'")
            return nil
        }

        do {
            let url = URL(fileURLWithPath: path)
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let data = try decoder.decode([Country].self, from: jsonData)
            return data
        } catch {
            // Xử lý lỗi một cách nghiêm túc hơn
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    func getFileJsonAbout() -> [About]? {
        guard let path = Bundle.main.path(forResource: "abouts", ofType: "json") else {
            // Không tìm thấy tệp "emails.json" trong bundle của ứng dụng
            print("Error: Could not find file 'json'")
            return nil
        }

        do {
            let url = URL(fileURLWithPath: path)
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let data = try decoder.decode([About].self, from: jsonData)
            return data
        } catch {
            // Xử lý lỗi một cách nghiêm túc hơn
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    func getFileJsonOurApp() -> [OurApp]? {
        guard let path = Bundle.main.path(forResource: "our_app", ofType: "json") else {
            // Không tìm thấy tệp "emails.json" trong bundle của ứng dụng
            print("Error: Could not find file 'json'")
            return nil
        }

        do {
            let url = URL(fileURLWithPath: path)
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let data = try decoder.decode([OurApp].self, from: jsonData)
            return data
        } catch {
            // Xử lý lỗi một cách nghiêm túc hơn
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    
}

struct Test : Codable{
    let name: String
}
