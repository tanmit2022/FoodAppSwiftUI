//
//  InputView.swift
//  FoodApp
//
//  Created by Ap on 29/03/26.
//

import SwiftUI

struct InputView: View {
    var placeHolder: String
    var isSecureField: Bool = false
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 10) {
            if isSecureField {
                SecureField(placeHolder, text: $text)
            }else{
                TextField(placeHolder, text: $text)
            }
            Divider()
                .background(Color.black)
        }
    }
}

#Preview {
    InputView(placeHolder: "Enter Phone number", text: .constant(""))
}




func showAlert(title: String, message: String)->Alert {
    Alert(
        title: Text("\(title)"),
        message: Text(message),
        dismissButton: .default(Text("OK"))
    )
}
 
