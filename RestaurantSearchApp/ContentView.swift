//
//  ContentView.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/02
//  
//

import SwiftUI

struct ContentView: View {
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
            
            
            CapsuleButton(
                text: "始める",
                onClicked: {
                    
                })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
