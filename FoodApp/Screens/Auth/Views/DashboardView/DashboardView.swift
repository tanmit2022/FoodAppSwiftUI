//
//  DashboardView.swift
//  FoodApp
//
//  Created by Amit on 08/04/26.
//
import SwiftUI
struct DashboardView: View {
 
    @EnvironmentObject var navigationModel: NavigationModel

    var body: some View {
        TabView {
            ProfileRootView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                    
                }
            HomeRootView1()
                .tabItem {
                    Label("Menu", systemImage: "house.fill")
                }
            
        }
    }
}
 
#Preview {
    DashboardView()
}
