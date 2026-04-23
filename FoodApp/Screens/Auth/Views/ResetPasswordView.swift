//
//  ResetPasswordView.swift
//  FoodApp
//
//  Created by Ap on 29/03/26.
//

import SwiftUI
import SVProgressHUD

struct ResetPasswordView: View {
    
    //@Environment(\.dismiss) var dismiss
    var getOtp: String = ""
    var getPhone: String = ""

    @State private var otp: String = ""
    @State private var newPassword: String = "admin"
    @State private var confirmPassword: String = "admin"

    @EnvironmentObject var rootModel: RootViewModel
    @EnvironmentObject var navigationModel: NavigationModel

    @State private var errorMsg: String = ""
    @State private var alertShow: Bool = false
    
    var body: some View {
        ZStack {
            gradientBgView
            VStack(spacing: 20) {
                VStack{
                    Text("Change Password")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Please enter and confirm your new password.")
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                        .padding(.top)
                }.padding(.top, 10)
                // .frame(height: 250)
                
                VStack(spacing: 20){
                    
                    InputView(placeHolder: "OTP 6 digit", text: $otp).padding(.bottom, 25)
                    
                    InputView(placeHolder: "New Password", isSecureField: true, text: $newPassword)
                    InputView(placeHolder: "Confirm Password", text: $confirmPassword)
                }
                .padding(.top,20)
                Button{
                    callWebservice_resetPass()
                }label: {
                    Text("Submit")
                        .fontWeight(.semibold)
                    
                }.buttonStyle(CapsuleButtonStyle())
                    .padding(.top, 25)
                Spacer()
                Button("Dismiss"){
                    navigationModel.path.pop()
                }
                .foregroundStyle(.black)
            }.padding()
        }
        .onAppear(){
            otp = getOtp
        }
        
        .alert(isPresented: $alertShow) {
            UtzoSwiftUI.showAlert(title: "Error", message: errorMsg)
        }
    }
    func callWebservice_resetPass(){
        
        var parama = [String: String]()
        parama["code"] = otp
        parama["phone"] = getPhone
        parama["new_password"] = newPassword

        print("\(NetWorkingConstants.account.restPass) parama: \(parama)")
        SVProgressHUD.show()

        APIManager.shared.requestWithParams(isAuth: false,NetWorkingConstants.account.restPass, method: .post, parameters: parama) { json, response, error in
            print("login json: \(json)")
            
            if response?.success == ServerCode.Success {
                //dismiss()
                rootModel.flow = .auth
                navigationModel.path.popToRoot()
            }else{
                errorMsg = response?.message ?? ""
                alertShow = true
            }
            SVProgressHUD.dismiss()
        }
    }
}



#Preview {
    ResetPasswordView()
}
