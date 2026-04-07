//
//  RootViewModel.swift
//  FoodApp
//
//  Created by Amit on 03/04/26.
//

import SwiftUI
import Combine



final class RootViewModel: ObservableObject {
    @Published var flow: AppFlow = .splash

    
   // @Published var isLogin: Bool = false
     @Published var userModel = UserModel()
    
//    @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn") {
//        didSet {
//            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
//        }
//    }
}
