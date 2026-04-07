//
//  RootView.swift
//  FoodApp
//
//  Created by Amit on 03/04/26.
//
import SwiftUI
import SVProgressHUD
import Alamofire
import SwiftyJSON

struct RootView: View {
    
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var rootModel: RootViewModel

    
    var body: some View {
        
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [.orange, .blue]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            switch rootModel.flow {
            case .splash:
                SplashView()
                
            case .auth:
                AuthView()
                    
            //case .main(let role):
            case .main:
                ProfileView()
                
            case .signup:
                SignupView()
            }
        }
        
//        .navigationDestination(type: Route.self, destination: {
//            screen in
//            RouteBuilder.build(screen, nav: navigationModel)
//        })
    }
}
