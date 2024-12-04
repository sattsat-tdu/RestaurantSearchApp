//
//  HomeView.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/02
//  
//

import SwiftUI
import MapKit


struct HomeView: View {
    
    @State private var position: MapCameraPosition =
        .userLocation(fallback: .automatic)
    @State private var isInteracting = false
    @FocusState var isFocus: Bool
    
    var body: some View {
        ZStack {
            
            mapView
            if isFocus {
                Color.black.opacity(0.7).edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isFocus = false // 背景タップでキーボードを閉じる
                    }
            }
            SearchView(isFocus: $isFocus)
                .opacity(isInteracting ? 0.2 : 1)
                .focused($isFocus)
        }
    }
    
    private var mapView: some View {
        Map(position: $position) {
            UserAnnotation()
        }
        .tint(.orange)
        .onMapCameraChange(frequency: .continuous) {
            if !position.followsUserLocation && !isInteracting {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isInteracting = true
                }
            }
        }
        .onMapCameraChange(frequency: .onEnd) {
            if isInteracting && !position.followsUserLocation {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isInteracting = false
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            Button(action: {
                position = .userLocation(fallback: .automatic)
            }) {
                Image(systemName: "location.fill")
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
            .opacity(isInteracting ? 0.2 : 1)
            .padding(.trailing, 16)
            .padding(.bottom, 16)
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LocationManager())
}
