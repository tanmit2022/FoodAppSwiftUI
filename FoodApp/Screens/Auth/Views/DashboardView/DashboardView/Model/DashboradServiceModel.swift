//
//  DashboradServiceModel.swift
//  UtzoSwiftUI
//
//  Created by Amit on 23/04/26.
//

import SwiftUI

 
class DashboradServiceModel: Identifiable, ObservableObject {
    let id = UUID()
    @Published var name: String = ""

    init(name: String) {
        self.name = name
    }
}
