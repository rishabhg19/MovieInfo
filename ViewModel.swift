//
//  ViewModel.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/4/25.
//

import Foundation


@MainActor
class ViewModel: ObservableObject {
    @Published var trendingMovies: [TrendingMovie] = []
    @Published var favorites: [TrendingMovie] = []
    var timeWindow: String = "day" {
        didSet {
            Task {
                await fetchMovies()
            }
        }
    }
    
    func fetchMovies() async {
        let cachedMovies = CacheManager.cache.readTrendingCache(timeWindow: self.timeWindow)
        if !cachedMovies.isEmpty {
            trendingMovies = cachedMovies
            print("USING CACHE \n\n\n\n\n\n")
            return
        }
        
        if let downloadedMovies = await TMDBAPICaller().getTrendingMovieList(timeWindow: self.timeWindow) {
            trendingMovies = downloadedMovies
            CacheManager.cache.writeTrendingCache(downloadedMovies, timeWindow: self.timeWindow)
        } else {
            print("Error while retrieving trending movies from API")
        }
        
    }
    
    func toggleFavorite(_ movie: TrendingMovie) {
        if let index = favorites.firstIndex(where: { $0.id == movie.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(movie)
        }
    }
    
    func isFavorite(_ movie: TrendingMovie) -> Bool {
        favorites.contains(where: { $0.id == movie.id })
    }

    func removeFavorite(_ movie: TrendingMovie) {
        favorites.removeAll { $0.id == movie.id }
    }
}
