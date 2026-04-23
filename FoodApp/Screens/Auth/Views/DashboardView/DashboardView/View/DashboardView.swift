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
    
    let ary = [DashboradServiceModel(name: "Plumbing Repair"),
               DashboradServiceModel(name: "Plumbing Services"),
               DashboradServiceModel(name: "Water Heater"),
               DashboradServiceModel(name: "Toilet"),
    ]
    
    
    var body: some View {
        VStack(){
            BrandedNavBar()
            
            //Serach view
            searchView
            GeometryReader { proxy in
                let screenWidth = proxy.size.width
                let gridHeight = screenWidth / 2.2
                
                ScrollView{
                    
                    VStack{
                        HStack{
                            Text("Plumbing Services")
                            //.fontWeight(.semibold)
                                .font(.system(size: 14,weight: .medium))
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        VStack(spacing: 12){
                            ServiceCardView(imageName: "Dish Washer",name: "Plumbing Services",size: CGSize(width: screenWidth , height: gridHeight))
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 12) {
                                    
                                    ForEach(ary) { item in
                                        
                                        ServiceCardView(imageName: item.name,name: item.name,size: CGSize(width: gridHeight, height: gridHeight))
                                            .frame(width: gridHeight)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
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
            .padding()
    }
    
    
}

#Preview {
    DashboardView()
}





