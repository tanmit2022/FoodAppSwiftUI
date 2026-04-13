//
//  LoginView.swift
//  FoodApp
//
//  Created by Ap on 28/03/26.
//

import SwiftUI
import SVProgressHUD
import Alamofire
import SwiftyJSON

struct LoginView: View {
    @State private var phone: String = "90749742"
    @State private var password: String = "admin"

    @State private var alertShow: Bool = false
    @State private var alertMsg: String = ""
    
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var rootModel: RootViewModel
    
    var body: some View {
        
        ZStack {
            
            gradientBgView
            
            VStack(spacing:40) {
                //Spacer(minLength: 20)
                VStack{
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Let's Connect with us!")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                }
                .frame(height: 250)
                
                VStack(spacing: 20){
                    InputView(placeHolder: "Phone number", text: $phone)
                    InputView(placeHolder: "Password", isSecureField: true, text: $password)
                    
                    HStack{
                        Spacer()
                        Button{
                            navigationModel.path.append(Route.forgotPasswordView)
                           // goToForgot = true
                        }label: {
                            Text("Forgot Password?")
                                .foregroundStyle(.bar)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .underline()
                        }
                    }
                    HStack{
                        Spacer()
                        Text("New User?")
                        
                        Button{
                            navigationModel.path.append(Route.signupView)

                        }label: {
                            Text("Signup")
                                .foregroundStyle(.bar)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .underline()
                        }
                    }
                    Button{
                        callWebservice_getAccessToken()
                        
                    }label: {
                        Text("Login")
                            .fontWeight(.semibold)
                    }.buttonStyle(CapsuleButtonStyle())
                        .disabled(phone.isEmpty)
                        .opacity(phone.isEmpty ? 0.5 : 1.0)
                }
                Spacer()
            }
            .padding(.horizontal)

            .alert(isPresented: $alertShow) {
                FoodApp.showAlert(title: "Message", message: alertMsg)
            }
        }
    }

    func callWebservice_getAccessToken(){
        SVProgressHUD.show()

        let phone = phone.trimmingCharacters(in: .whitespaces)
        let pass = password.trimmingCharacters(in: .whitespaces)
        
        var parama = [String: String]()
        parama["phone"] = phone
        parama["password"] = pass
        print("\(NetWorkingConstants.auth.accessToken) parama: \(parama)")
        
        
        APIManager.shared.requestWithParams(isAuth: false,NetWorkingConstants.auth.accessToken, parameters: parama) { json, response, error in
            SVProgressHUD.dismiss()
            
            if response?.success == ServerCode.Success {
                print("json auth: \(json)")
                let data = json["data"]
                let accessToken = data["access"].stringValue
                let refreshToken = data["refresh"].stringValue
                let expiresIn = data["expiry_token_in"].doubleValue
                
                TokenStorage.accessToken = accessToken
                TokenStorage.refreshToken = refreshToken
                TokenStorage.expiryDate = "\(Date().addingTimeInterval(expiresIn).timeIntervalSince1970)"
                
                //print("TokenStorage.accessToken: \(TokenStorage.accessToken)")
                self.callWebservice_login(phone: phone, password: pass)
                
            }else{
                alertMsg = response?.message ?? ""
                alertShow = true
            }
        }
    }
    func callWebservice_login(phone: String, password: String){
        
        var parama = Parameters()
        parama["phone"] = phone
        parama["password"] = password
        print("\(NetWorkingConstants.account.login) parama: \(parama)")
        SVProgressHUD.show()

        APIManager.shared.requestWithParams(NetWorkingConstants.account.login, parameters: parama) { json, response, error in
            print("login json: \(json)")
            SVProgressHUD.dismiss()
            
            if response?.success == ServerCode.Success {
                let user = UserModel()
                user.setData(json: json)
                rootModel.userModel = user
               // self.goToHome = true
                rootModel.flow = .main
            }else{
                alertMsg = response?.message ?? ""
                alertShow = true
            }
        }
    }
}

//#Preview {
//    LoginView(userModel: userModel)
//}




var gradientBgView: some View {
    LinearGradient(
        gradient: Gradient(colors: [.purple, .blue]),
        startPoint: .top,
        endPoint: .bottom
    )
    .ignoresSafeArea()
}
struct CapsuleButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(.white))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Scale down when pressed
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed) // Smooth animation
    }
}
