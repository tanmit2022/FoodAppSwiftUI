//
//  SwiftUIView.swift
//  FoodApp
//
//  Created by Ap on 29/03/26.
//

import SwiftUI
import SwiftyJSON

class UserModel: ObservableObject {
    
    var first_name = ""
    var last_name = ""
    var city = ""
    var phone = ""
    var created_at = ""
    
    init(first_name: String = "", last_name: String = "", city: String = "", phone: String = "", created_at: String = "") {
        self.first_name = first_name
        self.last_name = last_name
        self.city = city
        self.phone = phone
        self.created_at = created_at
    }
    
    func setData(json: JSON?) {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        let userData = json?["data"]
        
        if let first_name = userData?["first_name"].stringValue {
            self.first_name = first_name
            userDefaults.set(first_name, forKey: "first_name")
        }
        
        if let last_name = userData?["last_name"].stringValue {
            self.last_name = last_name
            userDefaults.set(last_name, forKey: "last_name")
        }
        
        if let city = userData?["city"].stringValue {
            self.city = city
            userDefaults.set(city, forKey: "city")
        }
        
        if let phone = userData?["phone"].stringValue {
            self.phone = phone
            userDefaults.set(phone, forKey: "phone")
        }
        
        if let created_at = userData?["created_at"].stringValue {
            self.created_at = changeDateFormat(from: "yyyy-MM-dd HH:mm:ss", to: "MM/dd/yyyy | hh:mm a", strDate: created_at)
            userDefaults.set(self.created_at, forKey: "created_at")
        }
        
        
        if let access = userData?["access"].stringValue,let refresh = userData?["refresh"].stringValue,let expiresIn = userData?["expiry_token_in"].doubleValue {
            TokenStorage.accessToken = access
            TokenStorage.refreshToken = refresh
            TokenStorage.expiryDate = "\(Date().addingTimeInterval(TimeInterval(expiresIn)).timeIntervalSince1970)"
        }
        
    }
    
    func getProfileFromLoginUser(){
        
        let userDefaults: UserDefaults = UserDefaults.standard
        
        
        if let first_name = userDefaults.object(forKey: "first_name") as? String {
            self.first_name = first_name
        }
        
        if let last_name = userDefaults.object(forKey: "last_name") as? String{
            self.last_name = last_name
        }
        
        if let city = userDefaults.object(forKey: "city") as? String {
            self.city = city
        }
        
        if let phone = userDefaults.object(forKey: "phone") as? String {
            self.phone = phone
        }
        
        if let created_at = userDefaults.object(forKey: "created_at") as? String {
            self.created_at = created_at
        }
    }
}




