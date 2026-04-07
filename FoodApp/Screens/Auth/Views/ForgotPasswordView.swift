//
//  ForgotPasswordView.swift
//  FoodApp
//
//  Created by Ap on 29/03/26.
//

import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject var navigationModel: NavigationModel

    @State private var oldPass: String = ""
    @State private var pass: String = ""
    @State private var confirmPass: String = ""
    
    var body: some View {
        NavigationStack{
            ZStack {
                gradientBgView
                VStack(spacing: 20) {
                    VStack{
                        Text("Forgot Password")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                      
                        Text("Please complete all information to create an account")
                            .multilineTextAlignment(.center)
                            .fontWeight(.medium)
                            .padding(.top)
                    }.padding(.top, 10)
                   // .frame(height: 250)

                    

                    
                    VStack(spacing: 20){
                        
                        InputView(placeHolder: "Enter phone no.", text: $oldPass).padding(.bottom, 25)
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
    ForgotPasswordView()
}
