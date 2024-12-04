//
//  GourmetAPIManager.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/03
//
//

import Foundation

class GourmetAPIManager {
    // シングルトン
    static let shared = GourmetAPIManager()
    
    // 課題のため apiKey をハードコーディング
    private let apiKey = "554e1b6ef0256401"
    private let baseUrl = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
    
    func fetchRestaurants(searchQuery: SearchQuery) async -> Result<ShopsResponse, APIError> {

        guard var urlComponents = URLComponents(string: baseUrl) else {
            return .failure(APIError.invalidURL)
        }
        
        var queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "keyword", value: "レストラン") // レストランアプリであるため固定のキーワード
        ]
        
        if let keyword = searchQuery.keyword {
            queryItems.append(URLQueryItem(name: "keyword", value: keyword))
        }
        
        if let lat = searchQuery.lat {
            queryItems.append(URLQueryItem(name: "lat", value: String(lat)))
        }
        
        if let lng = searchQuery.lng {
            queryItems.append(URLQueryItem(name: "lng", value: String(lng)))
        }
        
        if let range = searchQuery.range {
            queryItems.append(URLQueryItem(name: "range", value: "\(range)"))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return .failure(APIError.invalidURL)
        }
        
        print("リクエスト URL: \(url.absoluteString)")
        
        // リクエストを作成
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            // API通信
            let (data, _) = try await URLSession.shared.data(for: request)
            
            do {
                let fetchedShopsResponse = try JSONDecoder().decode(ShopsResponse.self, from: data)
                return .success(fetchedShopsResponse)
            } catch {
                return .failure(APIError.parseError)
            }
        } catch {
            // エラー発生時
            return .failure(.urlSessionError)
        }
    }
}

// APIエラー型
enum APIError: Error {
    case parseError
    case urlSessionError
    case invalidURL
    case invalidResponse
}
