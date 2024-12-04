//
//  SearchBar.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/03
//  
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 24) {
            Image(systemName: "location.magnifyingglass")
            
            TextField("お店の名前を検索", text: $searchText)
            
            // 検索文字が空ではない場合は、クリアボタンを表示
            if !searchText.isEmpty {
                Button {
                    searchText.removeAll()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
        .fontWeight(.semibold)
        .keyboardType(.default)
        .padding(.vertical)
        .padding(.horizontal)
        .background(Color(.systemGray6))
        .clipShape(Capsule())
        .shadow(radius: 3)
    }
}

#Preview {
    @Previewable @State var searchText = "サンプル"
    SearchBar(searchText: $searchText)
}
