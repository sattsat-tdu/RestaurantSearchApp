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
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
                .submitLabel(.search)
                .onSubmit {
                    print("検索しました")
                }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SearchView()
}
