//
//  AuthView.swift
//  FoodApp
//
//  Created by Amit on 06/04/26.
//
import SwiftUI

struct AuthView: View {
    @EnvironmentObject var rootModel: RootViewModel
 
    var body: some View {
        VStack {
            //Text("Login")
            LoginView()
 
        }
    }
}
