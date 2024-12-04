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
    
    func fetchRestaurants() async -> Result<String, Error> {
        // URL作成
        guard var urlComponents = URLComponents(string: baseUrl) else {
            return .failure(APIError.invalidURL)
        }
        
        // パラメータ設定
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "format", value: "json"), // JSON形式で取得
            URLQueryItem(name: "keyword", value: "レストラン") // 固定のキーワード
        ]
        
        guard let url = urlComponents.url else {
            return .failure(APIError.invalidURL)
        }
        
        // リクエストを作成
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            // API通信
            let (data, _) = try await URLSession.shared.data(for: request)
            
            // JSONを文字列に変換してそのまま返す
            if let jsonString = String(data: data, encoding: .utf8) {
                return .success(jsonString)
            } else {
                return .failure(APIError.invalidResponse)
            }
        } catch {
            // エラー発生時
            return .failure(error)
        }
    }
}

// APIエラー型
enum APIError: Error {
    case invalidURL
    case invalidResponse
}
