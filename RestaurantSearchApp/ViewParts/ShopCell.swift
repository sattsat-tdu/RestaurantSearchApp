//
//  ShopCell.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/06
//  
//

import SwiftUI

struct ShopCell: View {
    
    let shop: Shop
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(.red)
                .frame(width: 128, height: 128)
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

#Preview {
    
    ShopCell(shop: Shop(
        id: "1234",
        name: "店の名前",
        logo_image: "https://source.unsplash.com/random/300x200",
        address: "千代田区丸の内１丁目",
        station_name: "東京",
        lat: 0.0000,
        lng: 0.0000,
        capacity: 356,
        mobile_access: "東京駅より徒歩5分",
        open: "月〜金",
        close: "土日")
    )
}
