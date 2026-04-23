//
//  NetworkingConstants.swift
//  SampleApp
//
//  Created by Amit on 23/03/26.
//

import Foundation



//--*******-******--Settings(DEVELOPMENT/PRODUCTION)--*******-*******-
struct APISettings {
    static let API_BASE_URL = APIs.DEVELOPMENT
    
    
}//end


//---API---
let LOCAL_DOMAIN = "192.168.1.200"//
struct APIs {
    static let PRODUCTION = "https://www.utzo.com/"//Production
    static let DEVELOPMENT = "http://\(LOCAL_DOMAIN)/pickedin.com/"//Development
}
 


var MAIN_BASE =   APISettings.API_BASE_URL + "api/customer?"

struct NetWorkingConstants {
    static var MAIN_BASE =   APISettings.API_BASE_URL + "api/customer?"

    struct account {
        static let signup = MAIN_BASE + "signup/"
        static let login = MAIN_BASE + "login/"
        static let changePass = MAIN_BASE + "change-password/"
        static let restPass = MAIN_BASE + "reset-password/"
        static let forgotPass = MAIN_BASE + "forgot-password/"
        static let resend = MAIN_BASE + "resend-otp/"
        static let logout = MAIN_BASE + "logout/"
        static let getUserProfile = MAIN_BASE + "user-profile/"

        
    }
    struct auth {
        static let accessToken = MAIN_BASE + "token/"
        static let refreshToken = MAIN_BASE + "token-refresh/"
    }
    
    
}

