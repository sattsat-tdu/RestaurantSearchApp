//
//  SearchView.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/03
//  
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
                .submitLabel(.search)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SearchView()
}
