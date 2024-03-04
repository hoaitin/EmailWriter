//
//  AIPManager.swift
//  BaseProjectApp
//
//  Created by Tin Nguyen on 19/02/2024.
//  Copyright © 2024 Vulcan Labs. All rights reserved.
//

import Foundation
import Qonversion



class AIPManager {
    public static let share:  AIPManager = AIPManager()
    
    private init(){}
    
    public func configure(complition: @escaping (Bool)-> Void){
        Qonversion.launch(withKey: "0ueUR4v41IA3mgnK9DV-SFuRD23AqbFu" ) { result, error in
            guard error == nil else {
                complition(false)
                return
            }
            
            print("id: \(result.uid)")
            complition(true)
        }
        
    }
    
    
    
    public func checkPermission(idPermission:String,complition: @escaping (Bool)-> Void ){
        Qonversion.checkPermissions { permissions, error  in
               if let error = error {
                   complition(false)
               } else {
               
                   if let premiumPermission = permissions[idPermission] {
                       if premiumPermission.isActive {
                           complition(true)
                       } else {
                           complition(false)
                       }
                   }
               }
        }
        
        
    }
    
    public func purchase(idProduct: String,complition: @escaping (Bool)-> Void){
        Qonversion.purchase(idProduct) { (entitlements, error, isCancelled) in
            guard error == nil else {
              
                complition(false)
                return
            }
            if isCancelled {
                complition(false)
                return
            }else{
                complition(true)
            }
            
        }
        
    }
    
    
//    public func offerings(nameOffering: String, completion: @escaping callback){
//        Qonversion.offerings { (offerings, error) in
//            if let error = error {
//                // Xử lý lỗi nếu có
//                completion(false,nil,error.localizedDescription)
//                return
//            }
//            
//            if let offering = offerings?.offering(forIdentifier: nameOffering) {
//              
//                let offeringProducts = offering.products // Danh sách các sản phẩm trong offering
//                var products = []
//                
//                for product in offeringProducts {
//                    let item = Product(id: product.qonversionID, price: product.prettyPrice)
//                    products.append(item)
//                        
//                }
//              
//                completion(true,products,"success")
//                
//            } else {
//                // Không tìm thấy offering với identifier "pro"
//                completion(false,nil,"Không tìm thấy offering")
//            }
//        }
//        
//    }
//    
    public func restorePurchase(complition: @escaping (Bool)-> Void){
        Qonversion.restore { result , error in
            if let error = error {
                complition(false)
                return
            }
            complition(true)
            print("====>\(result)")
        }
        
    }
    
    
    
}
