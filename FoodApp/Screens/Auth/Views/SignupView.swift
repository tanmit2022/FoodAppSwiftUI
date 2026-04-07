//
//  SignupView.swift
//  FoodApp
//
//  Created by Ap on 29/03/26.
//

import SwiftUI
import SVProgressHUD
import Alamofire
import SwiftyJSON

struct SignupView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var rootModel: RootViewModel

    @State private var phone: String = "987654321"
    @State private var fName: String = "AA"
    @State private var lName: String = "BB"
    @State private var city: String = "FD"
    @State private var password: String = "admin"
    @State private var confirmPassword: String = "admin"
     
 
    @State private var alertShowSucces: Bool = false
    @State private var alertShowError: Bool = false
    @State private var alertMsg: String = ""
    

    var body: some View {
        ZStack {
            
            gradientBgView
            
            VStack(spacing: 50) {
                
                VStack(spacing: 20){
                    Text("Signup")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Please complete all information to create an account")
                        .multilineTextAlignment(.center)
                        .fontWeight(.medium)
                }
                
                VStack(spacing: 20){
                    
                    InputView(placeHolder: "Phone number", text: $phone)
                    InputView(placeHolder: "First name", text: $fName)
                    InputView(placeHolder: "Last name", text: $lName)
                    InputView(placeHolder: "City", text: $city)
                    InputView(placeHolder: "Password", isSecureField: true, text: $password)
                    InputView(placeHolder: "Confirm password", isSecureField: true, text: $confirmPassword)
                }
                Button{
                    callWebservice_register()
                }label: {
                    Text("Signup")
                        .fontWeight(.semibold)
                    
                }.buttonStyle(CapsuleButtonStyle())
                Button("Dismiss"){
                    dismiss()
                }
                .foregroundStyle(.black)
                
                Spacer()
                
            }.padding()
        }
        .alert(isPresented: $alertShowError) {
            FoodApp.showAlert(title: "Message", message: alertMsg)
        }
        .alert("Message", isPresented: $alertShowSucces) {
            Button("Ok", role: .cancel) {
                dismissView()
            }
        } message: {
            Text(alertMsg)
        }
    }
    
    func callWebservice_register(){
        
        var parama = Parameters()
        parama["phone"] = phone
        parama["first_name"] = fName
        parama["last_name"] = lName
        parama["city"] = city
        parama["password"] = password
        print("\(NetWorkingConstants.account.signup) parama: \(parama)")
        SVProgressHUD.show()

        APIManager.shared.requestWithParams(isAuth: false,NetWorkingConstants.account.signup, method: .post, parameters: parama) { json, response, error in
            print("login json: \(json)")
            
            if response?.success == ServerCode.Success {
                
                let user = UserModel()
                user.setData(json: json)
                rootModel.userModel = user
                
                alertMsg = response?.message ?? ""
                alertShowSucces = true
            }else{
                alertMsg = response?.message ?? ""
                alertShowError = true
            }
            SVProgressHUD.dismiss()
        }
    }
    private func dismissView(){
        DispatchQueue.main.async {
            dismiss()
            rootModel.flow = .auth
        }
    }
}

#Preview {
    SignupView()
}
