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
                bgSplashLogo
                
                switch rootModel.flow {
                case .splash:
                    SplashView()
                    
                case .auth:
                    //AuthView()
                    DashboardView()

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
var bgSplashLogo: some View {
    ZStack {
        LinearGradient(colors: [Color(hex: "BAEEFC"),Color(hex: "A7DBFF"),Color(hex: "A9C5F3")], startPoint: .top, endPoint: .bottom)
         Image("logoSplash")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipped()
            .frame(maxHeight: .infinity)
    }
    .ignoresSafeArea()
}
