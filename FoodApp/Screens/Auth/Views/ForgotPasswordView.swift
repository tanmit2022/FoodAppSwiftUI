//
//  ForgotPasswordView.swift
//  FoodApp
//
//  Created by Ap on 29/03/26.
//

import SwiftUI
import SVProgressHUD

struct ForgotPasswordView: View {
    //@Environment(\.dismiss) var dismiss

    @EnvironmentObject var navigationModel: NavigationModel

    @State private var otp: String = ""

    @State private var phone: String = ""
    
    @State private var errorMsg: String = ""
    @State private var alertShow: Bool = false
   // @State private var gotToRestPass: Bool = false
    
    var body: some View {
   
            ZStack {
                gradientBgView
                VStack(spacing: 20) {
                    VStack{
                        Text("Forgot Password")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                      
                        Text("Please provide the required information to continue.")
                            .multilineTextAlignment(.center)
                            .fontWeight(.medium)
                            .padding(.top)
                    }.padding(.top, 10)
                   // .frame(height: 250)

                    VStack(){
                        InputView(placeHolder: "Enter phone no.", text: $phone).padding(.bottom, 25)
                    }
                    .padding(.top,20)
                    
                    Button{
                        callWebservice_forgotPass()
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
//            .navigationDestination(isPresented: $gotToRestPass) {
//                ResetPasswordView(getOtp: otp, getPhone: phone)
//                    .navigationBarBackButtonHidden()
//            }
            .alert(isPresented: $alertShow) {
                FoodApp.showAlert(title: "Error", message: errorMsg)
            }
       
    }
    func callWebservice_forgotPass(){
        
        var parama = [String: String]()
        parama["phone"] = phone
        print("\(NetWorkingConstants.account.forgotPass) parama: \(parama)")
        SVProgressHUD.show()

        APIManager.shared.requestWithParams(isAuth: false,NetWorkingConstants.account.forgotPass, method: .post, parameters: parama) { json, response, error in
            print("login json: \(json)")
            
            if response?.success == ServerCode.Success {
                otp = json["code"].stringValue
                //gotToRestPass = true
                navigationModel.path.append(Route.resetPasswordView(otp: otp, phone: phone))
                
            }else{
                errorMsg = response?.message ?? ""
                alertShow = true
            }
            SVProgressHUD.dismiss()
        }
    }
}




#Preview {
    ForgotPasswordView()
}
