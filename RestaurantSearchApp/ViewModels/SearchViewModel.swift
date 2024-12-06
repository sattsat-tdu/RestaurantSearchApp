//
//  SearchViewModel.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/04
//  
//

import SwiftUI

enum NavigationDestination: Hashable {
    case shopListView(Results)
}

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
    
    @Published var searchText: String = ""  //keywordクエリー
    @Published var selectedRange: SearchRange = .d1000  //rangeクエリー
    @Published var navigationPath = NavigationPath()
    
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
            case .success(let response):
                print("成功!: \(response.results.results_available)件ヒットしました！")
                for shop in response.results.shop {
                    print(shop.name)
                }
                navigationPath.append(NavigationDestination.shopListView(response.results))
            case .failure(let failure):
                print("失敗！\(failure.localizedDescription)")
            }
        }
    }
}
