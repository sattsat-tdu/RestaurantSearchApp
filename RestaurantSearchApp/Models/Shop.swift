//
//  Shop.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/04
//  
//

struct ShopsResponse: Decodable {
    let results: Results
}

struct Results: Decodable {
    let results_available: Int
    let shop: [Shop]
}

struct Shop: Decodable {
    let id: String
    let name: String
    let logo_image: String
    let address: String
    let station_name: String
    let lat: Double
    let lng: Double
}
