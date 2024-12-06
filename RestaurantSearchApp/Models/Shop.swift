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

struct Results: Decodable, Hashable {
    // プロパティ
    let results_available: Int
    let shops: [Shop]
    
    enum CodingKeys: String, CodingKey {
        case results_available
        case shops = "shop"
    }
}

struct Shop: Decodable, Hashable {
    let id: String
    let name: String
    let logo_image: String
    let address: String
    let station_name: String
    let lat: Double
    let lng: Double
    let capacity: Int
    let mobile_access: String
    let photo: Photo
    let open: String
    let close: String
}

struct Photo: Decodable, Hashable {
    let pc: PhotoSize
    let mobile: PhotoSize
}

struct PhotoSize: Decodable, Hashable {
    let large: String
    let small: String

    enum CodingKeys: String, CodingKey {
        case large = "l"
        case small = "s"
    }
}
