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
    
    @StateObject private var viewModel = SearchViewModel()
    @EnvironmentObject var manager: LocationManager
    
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                
                mapView
                
                SearchView(viewModel: viewModel)
                    .opacity(isInteracting ? 0.2 : 1)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationDestination(for: NavigationDestination.self) { des in
                if case .shopListView(let results) = des {
                    ShopListView(results: results)
                }
            }
            .navigationBarHidden(true)
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
