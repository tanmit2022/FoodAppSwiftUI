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
    @EnvironmentObject var navigationModel: NavigationModel
    
    @State private var oldPass: String = "admin"
    @State private var pass: String = "amitpatel"
    @State private var confirmPass: String = "amitpatel"
    
    var body: some View {
        NavigationStack{
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
//                userModel.setData(json: json)
//                self.goToHome = true
              //  showAlert(title: "Error!", message: response?.message ?? "")

            }else{

               /// showAlert(title: "Error!", message: response?.message ?? "")
            }
        }
    }
}



#Preview {
    ChangePasswordView()
}
