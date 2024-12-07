//
//  ShopCell.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/06
//  
//

import SwiftUI
import Kingfisher

struct ShopCell: View {
    
    let shop: Shop
    
    var shopImage: String {
        return shop.photo.mobile.large
    }
    
    private let imageSize: CGFloat = 200
    
    var body: some View {
        VStack(alignment: .leading) {
            Color.clear
                .aspectRatio(contentMode: .fill)
                .overlay(
                    KFImage(URL(string: shopImage))
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
                        .scaledToFill()
                )
                .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(shop.name)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                Label(shop.mobile_access, systemImage: "mappin")
                    .foregroundStyle(.secondary)
                    .font(.caption)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .padding(8)
        }
        .background(Color(.systemGray6))
        .clipShape(.rect(cornerRadius: 8))
        .frame(maxWidth: .infinity)
    }
}
