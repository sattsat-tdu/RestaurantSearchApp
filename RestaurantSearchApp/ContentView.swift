//
//  ContentView.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/02
//  
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var manager: LocationManager
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: "location.app.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
                .frame(height: 80)
            
            VStack {
                Text("レストラン検索アプリ")
                    .font(.title2.bold())
                
                Text("素敵なグルメライフを楽しみましょう")
                    .foregroundStyle(.secondary)
            }

            Spacer()
            
            if manager.authorizationStatus != .notDetermined {
                Text("位置情報取得に許可する必要があります。\nもう一度「始める」を押して許可してください")
                    .foregroundStyle(.red)
            }
            
            CapsuleButton(
                text: "始める",
                onClicked: {
                    manager.requestPermission()
                })
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationManager())
}
