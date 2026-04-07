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

    @EnvironmentObject var rootModel: RootViewModel

    @State private var goToChangPass: Bool = false
    @State private var alertShow: Bool = false
    @State private var alertMsg: String = ""
    
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
                    
                    VStack(spacing:20){
                        ProfileView.DetailRow(msg: "Name", title: rootModel.userModel.first_name)
                        ProfileView.DetailRow(msg: "Phone no.", title: rootModel.userModel.phone)
                        ProfileView.DetailRow(msg: "City", title: rootModel.userModel.city)
                        ProfileView.DetailRow(msg: "Created at", title: rootModel.userModel.created_at)
                        //InputView(placeHolder: "Dummy", isSecureField: false, text: $msgTyping)
                    }
                    .padding(.top,20)
                    Button{
                        goToChangPass = true
                    }label: {
                        Text("Change Password")
                            .fontWeight(.semibold)
                            .underline()
                            .foregroundColor(.white)
                    }
                    
                    .padding(.top, 25)
                    Button{
                        alertMsg = "Are you sure you want to logout?"
                        alertShow = true
                        
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
            .navigationDestination(isPresented: $goToChangPass) {
                ChangePasswordView()
            }
   
            .alert("Message", isPresented: $alertShow) {
                Button("Ok", role: .destructive) {
                    connection_logout()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(alertMsg)
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
                TokenStorage.clear()
                rootModel.flow = .auth
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
}
