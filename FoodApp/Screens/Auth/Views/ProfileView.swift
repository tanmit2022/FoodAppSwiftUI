//
//  ProfileView.swift
//  FoodApp
//
//  Created by Ap on 29/03/26.
//


import SwiftUI
import SVProgressHUD
import Alamofire
import SwiftyJSON

struct ProfileView: View {
//var userModel: UserModel



    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var rootModel: RootViewModel

    
    var body: some View {
        NavigationStack{
            ZStack {
                gradientBgView
                VStack(spacing: 20) {
                    VStack{
                        Text("Home")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("User Details")
                            .multilineTextAlignment(.center)
                            .fontWeight(.medium)
                            .padding(.top)
                    }.padding(.top, 10)
                    // .frame(height: 250)
                    
                    //print("userModel.first_name: \(userModel.first_name)")
                    
                    VStack(spacing:20){
                        ProfileView.DetailRow(msg: "Name", title: rootModel.userModel.first_name)
                        ProfileView.DetailRow(msg: "Phone no.", title: rootModel.userModel.phone)
                        ProfileView.DetailRow(msg: "City", title: rootModel.userModel.city)
                        ProfileView.DetailRow(msg: "Created at", title: rootModel.userModel.created_at)
                        //InputView(placeHolder: "Dummy", isSecureField: false, text: $msgTyping)
                    }
                    .padding(.top,20)
                    Button{
                       
                        //navigationModel.path.append(Route.ChangePasswordView)
                    }label: {
                        Text("Change Password")
                            .fontWeight(.semibold)
                            .underline()
                            .foregroundColor(.white)
                    }
                    
                    .padding(.top, 25)
                    Button{
                        
                        connection_logout()
                        
                    }label: {
                        Text("Logout")
                            .fontWeight(.bold)
                            .underline()
                            .foregroundColor(.red)
                            .font(.system(size: 30))
                    }
                    Spacer()
                    
                }.padding()
            }
//            .navigationDestination(type: Route.self, destination: { route in
//                switch route {
//                case .ChangePasswordView:
//                    ChangePasswordView()
//                        .environmentObject(navigationModel)
//                    
//                default:
//                    EmptyView()
//                }
//            })
            
        }
    }
        
    private func connection_logout() {
        
        let parama: [String: String] = ["refresh": TokenStorage.refreshToken ?? ""]
        
        print("\(NetWorkingConstants.auth.refreshToken) parama: \(parama)")
        SVProgressHUD.show()
        
        APIManager.shared.requestWithParams(NetWorkingConstants.account.logout, parameters: parama) { json, response, error in
            print("logout json: \(json)")
            SVProgressHUD.dismiss()
            
            if response?.success == ServerCode.Success && error == nil {
                
                let userDict = json["data"].dictionaryValue
                
                let refresh_token = userDict["refresh_token"]?.stringValue
                let token = userDict["token"]?.stringValue
                let expiresIn = userDict["token_expires_in"]?.doubleValue ?? 0.0
                
                TokenStorage.accessToken = token
                TokenStorage.refreshToken = refresh_token
                TokenStorage.expiryDate = "\(Date().addingTimeInterval(TimeInterval(expiresIn)).timeIntervalSince1970)"
                // self.connection_getUserData()
                rootModel.flow = .auth

               // navigationModel.path.popToRoot()
                //Thread 1: Fatal error: No ObservableObject of type NavigationModel found. A View.environmentObject(_:) for NavigationModel may be missing as an ancestor of this view.
            }
        }
    }
    
    
    
    struct DetailRow: View {
         var msg: String
         var title: String

        var body: some View{
            HStack(spacing: 20){
                Text("\(msg):")
                    .backgroundStyle(.red)
                    .foregroundStyle(.black)
                    .opacity(0.6)
                
                
                Spacer()
                Text("\(title)")
            }
            
        }
    }
    
    
    func callWebservice_logout(){
        
      
        SVProgressHUD.show()

        APIManager.shared.requestWithParams(NetWorkingConstants.account.logout, parameters: ["refresh" : "\(TokenStorage.refreshToken ?? "")"]) { json, response, error in
            print("login json: \(json)")
            SVProgressHUD.dismiss()
            
            if response?.success == ServerCode.Success {
               
                
                
            }else{
//                errorMsg = response?.message ?? ""
//                showAlert = true
            }
        }
    }
}

//#Preview {
//    ProfileView()
//        .environmentObject(UserModel(name: "Amit Patel", phone: "9074974258", city: "Indore", createdAt: "20-3-2026"))
//
//}
