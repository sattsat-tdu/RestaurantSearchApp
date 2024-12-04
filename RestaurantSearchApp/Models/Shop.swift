//
//  Shop.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/04
//  
//

struct ShopsResponse: Decodable {
    let shops: [Shop]
}

struct Shop: Decodable {
    let id: String
    let name: String
    let logo_image: String
    let adress: String
    let station_name: String
    let lat: Double
    let lng: Double
}
