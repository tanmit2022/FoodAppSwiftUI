//
//  NavigationModel.swift
//  FoodApp
//
//  Created by Amit on 03/04/26.
//

import SwiftUI

class NavigationModel: ObservableObject {
   // @Published var path: [Route] = []

    @Published var path = NavigationPath()
}


class ProfileNavigationModel: ObservableObject {
    @Published var path = NavigationPath()
}
