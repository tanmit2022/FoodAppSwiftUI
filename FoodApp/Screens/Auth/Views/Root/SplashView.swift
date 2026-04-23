//
//  SplashView.swift
//  FoodApp
//
//  Created by Amit on 06/04/26.
//
import SwiftUI
import SVProgressHUD
import Alamofire
import SwiftyJSON

struct SplashView: View {
    @EnvironmentObject var rootModel: RootViewModel

    var body: some View {
        ZStack{
            bgSplashLogo
            VStack{
                BrandedNavBar()
                Spacer()
            }
        }
            .onAppear {
                //checkAuth()
            }
    }

    func checkAuth() {
        Task {
            //try? await Task.sleep(nanoseconds: 1_000_000_000) // simulate API
                        
            if TokenStorage.validExpiryDate() {
                // TODO: validate token via API
                callWebservice_getUserProfile()
                
            }else if TokenStorage.accessToken != "" {
                callWebservice_refreshToken()
                
            } else {
                rootModel.flow = .auth
            }
        }
    }
    
    func callWebservice_refreshToken(){
 
        SVProgressHUD.show()

        APIManager.shared.requestWithParams(NetWorkingConstants.auth.refreshToken,method: .post,parameters: ["refresh": TokenStorage.refreshToken]) { json, response, error in
            print("getUserProfile json: \(json)")
            SVProgressHUD.dismiss()
            
            if response?.success == ServerCode.Success {
                
                let userData = json["user_data"].dictionaryValue
                let refresh_token = userData["refresh"]?.stringValue
                let token = userData["access"]?.stringValue
                let expiresIn = userData["token_expires_in"]?.doubleValue ?? 0.0

                TokenStorage.accessToken = token
                TokenStorage.refreshToken = refresh_token
                TokenStorage.expiryDate = "\(Date().addingTimeInterval(expiresIn).timeIntervalSince1970)"
                callWebservice_getUserProfile()
            }else{
                rootModel.flow = .auth
            }
        }
    }
    func callWebservice_getUserProfile(){
        let parama: [String: String] = ["func": "user_profile"]

        SVProgressHUD.show()
        APIManager.shared.requestWithParams(NetWorkingConstants.MAIN_BASE,method: .post,parameters: parama) { json, response, error in
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

#Preview {
    SplashView()
}
