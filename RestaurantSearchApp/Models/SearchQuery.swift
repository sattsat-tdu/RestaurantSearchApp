//
//  SearchQuery.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/04
//  
//

//リクエストモデル

struct SearchQuery {
    let keyword: String?
    let lat: Double?
    let lng: Double?
    let range: Int?
    
    init(
        keyword: String? = nil,
         lat: Double? = nil,
         lng: Double? = nil,
         range: Int? = nil
    ) {
        self.keyword = keyword
        self.lat = lat
        self.lng = lng
        self.range = range
    }
}
