//
//  ProfileRootView.swift
//  FoodApp
//
//  Created by Amit on 08/04/26.
//

import SwiftUI

struct ProfileRootView: View {
    
    @StateObject private var navigationModel = ProfileNavigationModel()
    
    var body: some View {
        NavigationStack(path: $navigationModel.path) {
            ProfileView()
                .navigationDestination(for: ProfileRoute.self) { route in
                    ChangePasswordView()
                }
            
        }.environmentObject(navigationModel)
    }
}

#Preview {
    ProfileRootView()
}


enum ProfileRoute: Hashable, Codable {
    
    case changePasswordView
}
