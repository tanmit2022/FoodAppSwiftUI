//
//  SplashView.swift
//  FoodApp
//
//  Created by Amit on 06/04/26.
//
import SwiftUI
import SVProgressHUD

struct SplashView: View {
    @EnvironmentObject var rootModel: RootViewModel

    var body: some View {
        Text("Loading...")
            .onAppear {
                checkAuth()
            }
    }

    func checkAuth() {
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // simulate API

            if TokenStorage.validExpiryDate() {
                // TODO: validate token via API
                
                callWebservice_getUserProfile()
            } else {
                rootModel.flow = .auth
            }
        }
    }
    
    
    func callWebservice_getUserProfile(){
 
        SVProgressHUD.show()
        APIManager.shared.requestWithParams(NetWorkingConstants.account.getUserProfile,method: .get) { json, response, error in
            print("getUserProfile json: \(json)")
            SVProgressHUD.dismiss()
            
            if response?.success == ServerCode.Success {
                let user = UserModel()
                user.setData(json: json)
                rootModel.userModel = user
               // self.goToHome = true
                rootModel.flow = .main
            }else{
                rootModel.flow = .auth
            }
        }
    }
}
