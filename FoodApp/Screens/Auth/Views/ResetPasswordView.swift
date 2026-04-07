//
//  ResetPasswordView.swift
//  FoodApp
//
//  Created by Ap on 29/03/26.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var otp: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""

    @EnvironmentObject var navigationModel: NavigationModel

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
                        
                        InputView(placeHolder: "OTP 6 digit", text: $otp).padding(.bottom, 25)
                        
                        InputView(placeHolder: "New Password", isSecureField: true, text: $newPassword)
                        InputView(placeHolder: "Confirm Password", text: $confirmPassword)
                    }
                    .padding(.top,20)
                    Button{
                      
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
}



#Preview {
    ResetPasswordView()
}
