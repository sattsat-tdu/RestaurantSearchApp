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
                
            }
            Text("\(results.results_available)件ヒットしました！")
        }
    }
}

#Preview {
    ShopListView(results: Results(results_available: 0, shop: []))
}
