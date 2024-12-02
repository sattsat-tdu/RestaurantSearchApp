//
//  LocationManager.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/02
//  
//

import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus
    
    override init() {
        self.authorizationStatus = CLLocationManager().authorizationStatus
        super.init()
        locationManager.delegate = self
    }
    
    // 権限リクエスト
    func requestPermission() {
        switch authorizationStatus {
        case .notDetermined:    //認証を送っていない時
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:  //拒否していた場合は設定画面に遷移
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        default:
            fatalError("予期せぬ状態に遷移しました: authorizationStatus = \(authorizationStatus)")
        }
    }
    
    //権限を監視
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
    }
}
