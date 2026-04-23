//
//  DashboardView.swift
//  FoodApp
//
//  Created by Amit on 08/04/26.
//
import SwiftUI
struct DashboardView: View {
 
    @EnvironmentObject var navigationModel: NavigationModel

    @State private var txtSerach: String = ""
    
    let ary = ["Plumbing Repair","Plumbing Services","Water Heater","Toilet"]
    
    var body: some View {
        VStack(spacing:0){
            BrandedNavBar()
            VStack(spacing:20){
                //Serach view
                searchView

                ScrollView {
                    VStack{
                        HStack{
                            Text("Plumbing Services")
                                .fontWeight(.semibold)
                                .font(.headline)
                            Spacer()
                        }
                        
                        ServiceCardView(imageName: "Dish Washer",name: "Plumbing Services")
                        
                        
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<ary.enumerated()) { i in
                                    
                                    let name = ary[i]
                                    ServiceCardView(imageName: name,name: name)
                                        .frame(width: 120, height: 100)
                                        .background(Color.green.opacity(0.3))
                                        .cornerRadius(12)
                                }
                            }
                            .padding()
                            
                        }
                    }
                    
   
                    
                }
 
                //Spacer()
            } .padding()
        }
//        TabView {
//            ProfileRootView()
//                .tabItem {
//                    Label("Profile", systemImage: "person.circle")
//                }
//            HomeRootView1()
//                .tabItem {
//                    Label("Menu", systemImage: "house.fill")
//                }
//        }
    }
    
    
    
    var searchView: some View {
        HStack{
            TextField(text: $txtSerach) {
                Text("Search for services")
                    .font(.subheadline)
            }.textFieldStyle(.plain)
                .padding(8)
            
            Image(systemName:"magnifyingglass")
                .foregroundStyle(.gray)
                .font(.title3)
                .padding(5)
        }.frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0.3, y: 0)
            )
          //  .padding(.top,5)
    }
       
    
}
 
#Preview {
    DashboardView()
}





