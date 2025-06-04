//
//  AppRoot.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/4/25.
//

import Foundation
import SwiftUI

struct AppRoot: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            Text("TMDB Movies")
                .font(.largeTitle)
                .padding()
            
            TabView {
                NavigationStack {
                    TrendingView()
                        .environmentObject(viewModel)
                }
                .tabItem {
                    Label("Trending", systemImage: "film")
                }
                
                NavigationStack {
                    FavoritesView()
                        .environmentObject(viewModel)
                }
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            }
        }
    }
}

