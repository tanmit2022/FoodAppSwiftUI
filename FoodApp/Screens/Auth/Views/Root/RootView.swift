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

    @StateObject private var navigationModel = NavigationModel()
    @StateObject private var rootModel = RootViewModel()
    
    var body: some View {
 
        NavigationStack(path: $navigationModel.path) {
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
                    
                case .main:
                    DashboardView()
                }
                
            }
            .navigationDestination(for: Route.self) {  screen in
                RouteBuilder.build(screen, nav: navigationModel, root: rootModel)
            }
        }
        .environmentObject(navigationModel)
        .environmentObject(rootModel)
    }
}
