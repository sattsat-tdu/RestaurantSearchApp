//
//  HomeView.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/02
//  
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var manager: LocationManager
    
    var body: some View {
        Text("ホームです")
    }
}

#Preview {
    HomeView()
        .environmentObject(LocationManager())
}
