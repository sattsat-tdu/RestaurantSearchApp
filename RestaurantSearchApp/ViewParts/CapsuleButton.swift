//
//  CapsuleButton.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/02
//  
//

import SwiftUI

struct CapsuleButton: View {
    
    let text: String
    let onClicked: (() -> Void)
    
    var body: some View {
        Button(action: {
            onClicked()
        }, label: {
            Text(text)
                .font(.headline)
                .foregroundStyle(.background)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(.primary)
                .clipShape(Capsule())
        })
    }
}

#Preview {
    CapsuleButton(text: "サンプルテキスト",
                  onClicked: {
        print("クリックしました")
    })
}
