//
//  ShopListView.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/05
//  
//

import SwiftUI

struct ShopListView: View {
    
    let results: Results
    
    init(results: Results) {
        self.results = results
    }
    
    var body: some View {
        VStack {
            if results.results_available > 0 {
                
            } else {
                VStack {
                    Image(systemName: "house.slash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 128)
                    
                    Text("レストランが見つかりません")
                        .font(.headline)
                    
                    Label("検索範囲を広げてみてください",
                          systemImage: "lightbulb.max.fill")
                    .font(.callout)
                }
                .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("検索結果")
    }
}

#Preview {
    ShopListView(results: Results(results_available: 0, shop: []))
}
