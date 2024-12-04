//
//  SearchView.swift
//  RestaurantSearchApp
//  
//  Created by SATTSAT on 2024/12/03
//  
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    @EnvironmentObject var manager: LocationManager
    @FocusState.Binding var isFocus: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            SearchBar(searchText: $viewModel.searchText)
                .submitLabel(.search)
                .onSubmit {
                    print("ここにkeyword検索処理")
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("閉じる") {
                            isFocus = false
                        }
                    }
                }
            
            if isFocus {
                VStack(spacing: 24) {
                    rangeSettingBox
                    
                    Divider()
                    
                    searchNearMeButton
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 3)
            }
            
            Spacer()
        }
        .animation(.easeInOut, value: isFocus)
        .padding()
    }
    
    private var searchNearMeButton: some View {
        Button(action: {
            let location = manager.getUserLocation()
            viewModel.fetchNearMeRestaurants(
                lat: location?.lat,
                lng: location?.lng
            )
        }, label: {
            Label("現在地から検索", systemImage: "magnifyingglass")
                .fontWeight(.semibold)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background()
                .clipShape(Capsule())
        })
    }
    
    private var rangeSettingBox: some View {
        VStack(alignment: .leading, spacing: 24) {
            Label("検索範囲: \(viewModel.selectedRange.toMeters)m",
                  systemImage: "location.magnifyingglass")
            .font(.headline)
                
            
            ZStack {
                Slider(value: Binding(
                    get: {
                        Double(SearchRange.allCases.firstIndex(of: viewModel.selectedRange) ?? 0)
                    },
                    set: { newValue in
                        let index = Int(round(newValue))
                        viewModel.selectedRange = SearchRange.allCases[index]
                    }
                ), in: 0...Double(SearchRange.allCases.count - 1), step: 1)

                HStack {
                    ForEach(SearchRange.allCases, id: \.self) { range in
                        Text( "\(range.toMeters)m")
                            .font(.caption)
                            .offset(y: -25)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @FocusState var isFocus: Bool
    SearchView(isFocus: $isFocus)
}
