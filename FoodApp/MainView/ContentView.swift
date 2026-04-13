//
//  ContentView.swift
//  FoodApp
//
//  Created by Ap on 28/03/26.
//

import SwiftUI

//https://www.behance.net/gallery/234151789/Wagba-Food-Delivery-Mobile-App-UIUX-Design?utm_source=Pinterest&utm_medium=organic





struct ContentView: View {
    var body: some View {
        VStack{
            Text("Home")
            //RootView()
        }
    }
}

#Preview {
    ContentView()
}



//MARK: Navigation Bar
struct NoNavBarView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
    }
}


struct RouteBuilder {
    @ViewBuilder
    static func build(_ route: Route, nav: NavigationModel, root: RootViewModel) -> some View {
        NoNavBarView {
            switch route {
            case .signupView:
                SignupView()
                
            case .profileView:
                ProfileView()
              
            case .resetPasswordView(let otp, let phone):
                ResetPasswordView(getOtp: otp, getPhone: phone)
                
            case .changePasswordView:
                ChangePasswordView()
                
            case .forgotPasswordView:
                ForgotPasswordView()
            }
        }
    }
}
