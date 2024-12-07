//
//  LoadingView.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/08
//  
//

import SwiftUI

struct LoadingView: View {
    
    let scaleEffect: CGFloat = 2
    let size = UIScreen.main.bounds.width / 2.5
    
    var body: some View {
        
        Color.clear
            .edgesIgnoringSafeArea(.all)
            .overlay {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(scaleEffect)
                    .frame(width: scaleEffect * 20, height: scaleEffect * 20)
                    .padding(48)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 8))
            }
    }
}

#Preview {
    LoadingView()
}
