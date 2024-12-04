//
//  SearchViewModel.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/04
//  
//

import SwiftUI

enum SearchRange: Int, CaseIterable {
    case d300 = 1
    case d500 = 2
    case d1000 = 3
    case d2000 = 4
    case d3000 = 5
    
    /// 距離 (m) を取得
    var toMeters: Int {
        switch self {
        case .d300: return 300
        case .d500: return 500
        case .d1000: return 1000
        case .d2000: return 2000
        case .d3000: return 3000
        }
    }
}

final class SearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    //range設定
    @Published var selectedRange: SearchRange = .d1000
    
    @MainActor
    func fetchNearMeRestaurants(lat: Double?, lng: Double?) {
        Task {
            let result = await GourmetAPIManager.shared.fetchRestaurants(
                searchQuery: SearchQuery(
                    lat: lat,
                    lng: lng,
                    range: selectedRange.rawValue
                )
            )
            switch result {
            case .success(let shopsResponse):
                print("成功!")
                for shop in shopsResponse.results.shop {
                    print(shop.name)
                }
            case .failure(let failure):
                print("失敗！\(failure.localizedDescription)")
            }
        }
    }
}
