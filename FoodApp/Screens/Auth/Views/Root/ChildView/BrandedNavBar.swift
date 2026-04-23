//
//  BrandedNavBar.swift
//  UtzoSwiftUI
//
//  Created by Amit on 23/04/26.
//

import SwiftUI

struct BrandedNavBar: View {
    
 
    var body: some View {
        HStack {
            HStack{
                Button(action: {
                    // back action
                }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title)
                }

                Image("logoSplash")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 1)
                    )
                    .shadow(radius: 10)
            }

            Spacer()

            HStack{
                Button(action: {
                    // right action
                }) {
                    Image(systemName: "cart")
                        .font(.title2)
                }
                Button(action: {
                    // right action
                }) {
                    Image(systemName: "bell")
                        .font(.title2)

                }
            }
        }
        .padding(8)
        .background(Color.black)
        .foregroundColor(.white)
       

    }

}
#Preview {
    BrandedNavBar()
}
