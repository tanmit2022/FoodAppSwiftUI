//
//  AppState.swift
//  SwuftUINavigationStack
//
//  Created by Amit on 06/04/26.
//
import SwiftUI


enum AppFlow {
    case splash
    case auth
    case main
}
//enum AppFlow {
//    case splash
//    case auth
//    case main(UserRole)
//}
//
//enum UserRole {
//    case admin
//    case user
//}


enum Route: Hashable, Codable {
    case profileView
    case changePasswordView
    case forgotPasswordView
    case resetPasswordView(otp: String, phone: String)
    case signupView
}

 

