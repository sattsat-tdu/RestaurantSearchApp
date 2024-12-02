//
//  RestaurantSearchAppApp.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/02
//  
//

import SwiftUI

@main
struct RestaurantSearchAppApp: App {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    ContentView()
                case .authorizedWhenInUse, .authorizedAlways:
                    HomeView()
                @unknown default:
                    fatalError("予期せぬ状態遷移")
                }
            }
            .environmentObject(locationManager)
            .preferredColorScheme(.light)
        }
    }
}
