//
//  ForgotPasswordView.swift
//  FoodApp
//
//  Created by Ap on 29/03/26.
//

import SwiftUI
import Alamofire
import SVProgressHUD

struct ChangePasswordView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var rootModel: RootViewModel

    @State private var oldPass: String = "admin"
    @State private var pass: String = "amitpatel"
    @State private var confirmPass: String = "amitpatel"
    
    @State private var alertShowSucces: Bool = false
    @State private var alertShowError: Bool = false
    @State private var alertMsg: String = ""
    
    
    var body: some View {
        ZStack {
            gradientBgView
            VStack(spacing: 20) {
                VStack{
                    Text("Change Password")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Please complete all information to create an account")
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                        .padding(.top)
                }.padding(.top, 10)
                // .frame(height: 250)
                
                VStack(spacing: 20){
                    
                    InputView(placeHolder: "Old Password", text: $oldPass).padding(.bottom, 25)
                    
                    InputView(placeHolder: "New Password", isSecureField: true, text: $pass)
                    InputView(placeHolder: "Confirm Password", text: $confirmPass)
                }
                .padding(.top,20)
                Button{
                    callWebservice_changePassword(old: oldPass, new: confirmPass)
                }label: {
                    Text("Submit")
                        .fontWeight(.semibold)
                    
                    
                }.buttonStyle(CapsuleButtonStyle())
                    .padding(.top, 25)
                Spacer()
                
            }.padding()
        }
        
        .alert(isPresented: $alertShowError) {
            FoodApp.showAlert(title: "Message", message: alertMsg)
        }
        .alert("Message", isPresented: $alertShowSucces) {
            Button("Ok", role: .cancel) {
                dismiss()
                TokenStorage.clear()
                rootModel.flow = .auth
            }
        } message: {
            Text(alertMsg)
        }
    }
    
    func callWebservice_changePassword(old: String, new: String){
        
        var parama = Parameters()
        parama["old_password"] = old
        parama["new_password"] = new
        print("\(NetWorkingConstants.account.changePass) parama: \(parama)")
        SVProgressHUD.show()
        print("parama: \(parama)")
        APIManager.shared.requestWithParams(NetWorkingConstants.account.changePass, method: .put, parameters: parama) { json, response, error in
            print("changePass json: \(json)")
            print("changePass error: \(error)")
            SVProgressHUD.dismiss()
            
            if response?.success == ServerCode.Success {
                alertMsg = response?.message ?? ""
                alertShowSucces = true

            }else{
                alertMsg = response?.message ?? ""
                alertShowError = true
            }
        }
    }
    
    private func connection_logout() {
        
        let parama: [String: String] = ["refresh": TokenStorage.refreshToken ?? ""]
        SVProgressHUD.show()
        APIManager.shared.requestWithParams(NetWorkingConstants.account.logout, parameters: parama) { json, response, error in
            print("logout json: \(json)")
            SVProgressHUD.dismiss()
            
            if response?.success == ServerCode.Success {
                alertMsg = response?.message ?? ""
                alertShowSucces = true

            }else{
                alertMsg = response?.message ?? ""
                alertShowError = true
            }
        }
    }
}



#Preview {
    ChangePasswordView()
}
