//
//  ShopDetailView.swift
//  RestaurantSearchApp
//
//  Created by SATTSAT on 2024/12/06
//
//

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


import SwiftUI
import Kingfisher
import Combine
import MapKit

struct ShopDetailView: View {
    @Environment(\.dismiss) var dismiss
    let shop: Shop
    var shopImage: String {
        return shop.photo.mobile.large
    }
    private let shopLocation: CLLocationCoordinate2D
    private let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    @State private var position: MapCameraPosition
    
    init(shop: Shop) {
        self.shop = shop
        self.shopLocation = CLLocationCoordinate2D(
            latitude: shop.lat, longitude: shop.lng)
        // 初期の座標を設定
        self._position = State(initialValue: .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: shop.lat, longitude: shop.lng),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                shopLogo()
                
                VStack(spacing: 24) {
                    topTexts
                    
                    shopInfos
                    
                    miniMap
                }
                .padding()
                .frame(maxWidth: .infinity)
                .padding(.top, -48) //shopLogoの弊害により
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(.white)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    @ViewBuilder
    private func shopLogo() -> some View {
        let height = screenHeight * 0.4
        
        GeometryReader{ proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.4 : 0.5))
            
            ZStack {
                Color.clear
                    .frame(height: size.height)
                    .overlay(
                        KFImage(URL(string: shopImage))
                            .placeholder {
                                ProgressView()
                            }
                            .resizable()
                            .scaledToFill()
                    )
                    .clipped()
                
                Rectangle()
                    .fill(
                        .linearGradient(colors: [
                            .white.opacity(0 - progress),
                            .white.opacity(1),
                        ], startPoint: .center, endPoint: .bottom)
                    )
            }
            .offset(y:-minY)
        }
        .frame(height: height)
        .edgesIgnoringSafeArea(.top)
    }
    
    private var topTexts: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text(shop.name)
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(shop.catch)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.orange)
            

        }
    }
    
    private var shopInfos: some View {
        VStack(spacing: 16) {
            Text("お店の情報")
                .font(.headline)
            
            Divider()
            shopInfo(name: "店舗名", content: shop.name)
            shopInfo(name: "住所", content: shop.address)
            shopInfo(name: "最寄駅", content: "\(shop.station_name)駅")
            shopInfo(name: "アクセス", content: shop.mobile_access)
            shopInfo(name: "営業日", content: shop.open)
            shopInfo(name: "定休日", content: shop.close)
            shopInfo(name: "総席数", content: "\(shop.capacity)")
            shopInfo(name: "店舗URL", content: shop.urls.pc)
        }
    }
    
    @ViewBuilder
    private func shopInfo(name: String, content: String) -> some View {
        HStack(spacing: 24) {
            Text(name)
                .fontWeight(.semibold)
                .frame(width: 72, alignment: .leading)
            
            Text(content)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var miniMap: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("地図")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Map(position: $position) {
                UserAnnotation()
                
                Marker(coordinate: shopLocation) {
                    Text(shop.name)
                    Image(systemName: "fork.knife")
                }
            }
            .tint(.orange)
            .frame(height: 300)
            .cornerRadius(8)
        }
    }
}

#Preview {
    ShopDetailView(shop: Shop(
        id: "1234",
        name: "あいうえお",
        logo_image: "https://picsum.photos/200/300",
        address: "千代田区",
        station_name: "東京",
        lat: 0.0,
        lng: 0.0,
        capacity: 346,
        mobile_access: "東京駅から徒歩5分",
        photo: Photo(
            pc: PhotoSize(
                large: "https://picsum.photos/200/300",
                small: "https://picsum.photos/200/300"),
            mobile: PhotoSize(
                large: "https://picsum.photos/200/300",
                small: "https://picsum.photos/200/300")),
        open: "月~金",
        close: "土日",
        catch: "初心者歓迎！！",
        urls: Urls(pc: "https://")
    )
    )
}
