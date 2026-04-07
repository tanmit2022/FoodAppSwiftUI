//
//  WSResponse.swift
//  Utzo
//
//  Created by Mac on 05/04/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation
import SwiftyJSON


struct ServerCode {
   static let Success = "true"
   static let Error = 101
   static let SessionExpire = 401
}

@objc class WSResponse : NSObject{
    var code: Int
    var message: String
    var success: String
    var isInternet: Bool
    
    init(code: Int,success: String, message: String,jsonValue: JSON,isInternet: Bool) {
        self.isInternet = isInternet
        self.success = success
        self.code = code
        self.message = message
        if (jsonValue.null != nil) {
            self.message = "Something went wrong. Please try again"
        }else{
            if let errorMessage = jsonValue["global_error"].string {
                if !errorMessage.isEmpty {
                    self.message = self.message.isEmpty ? errorMessage : self.message
                }
            }
            
            self.message =  self.message.isEmpty ? self.message : jsonValue["message"].stringValue
            
            
            if (jsonValue["error"].dictionaryObject as [String: AnyObject]?) != nil {
                // Do something
                if (jsonValue["error"].dictionary?.keys.count)! > 0 {
                    self.message = self.message.isEmpty ? ((jsonValue["error"].dictionary?.first?.value.string) ?? "") : self.message
                }
            }
        }
    }
}

