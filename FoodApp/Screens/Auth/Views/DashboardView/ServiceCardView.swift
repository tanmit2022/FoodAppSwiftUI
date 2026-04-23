//
//  ServiceCardView.swift
//  UtzoSwiftUI
//
//  Created by Amit on 23/04/26.
//

import SwiftUI
struct ServiceCardView: View {
    var imageName: String = "Dish Washer"
    var name: String = "Plumbing Services"
    var size: CGSize = .zero
    var body: some View {
        VStack{
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: size.width,height: size.height)
                .overlay(
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0.0),
                            .init(color: .black.opacity(0.2), location: 0.7),
                            .init(color: .black.opacity(0.6), location: 1.0)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay(
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack {
                            Text(name)
                                .font(.subheadline)
                                .foregroundStyle(.white)
                            Spacer()
                        }.padding(10)
                       
                    } //.padding()
                )
                .cornerRadius(15)
                .clipped()
        }
    }
    
   
}

@ViewBuilder
func getCard(imageName: String,name: String)-> some View{
    VStack{
        Image(imageName)
            .resizable()
            .scaledToFill()
            .clipped()
            .overlay(
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: 0.0),
                        .init(color: .black.opacity(0.2), location: 0.7),
                        .init(color: .black.opacity(0.6), location: 1.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay(
                VStack(alignment: .leading) {
                    Spacer()
                    HStack {
                        Text(name)
                            .font(.subheadline)
                            .foregroundStyle(.white)
                        Spacer()
                    }.padding()
                   
                } //.padding()
            )
            .cornerRadius(15)
    }
}

#Preview {
    ServiceCardView(imageName: "Dish Washer", name: "Plumbing Services",size: CGSize(width: 360, height: 200))
}
