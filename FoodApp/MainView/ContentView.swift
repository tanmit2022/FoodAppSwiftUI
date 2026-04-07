//
//  ContentView.swift
//  FoodApp
//
//  Created by Ap on 28/03/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigationModel = NavigationModel()
    @StateObject private var rootModel = RootViewModel()

    var body: some View {
       
        NavigationStack(path: $navigationModel.path) {
            RootView()
        }
        .environmentObject(navigationModel)
        .environmentObject(rootModel)
        .navigationDestination(for: Route.self) {  screen in
            RouteBuilder.build(screen, nav: navigationModel, root: rootModel)
        }
//        .navigationDestination(type: Route.self, destination: {  screen in
//            RouteBuilder.build(screen, nav: navigationModel, root: rootModel)
//        })
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
                   // .environmentObject(nav)
                   // .environmentObject(root)
                
            case .profileView:
                ProfileView()
                   // .environmentObject(nav)
                   // .environmentObject(root)
            }
        }
    }
}
