//
//  ViewModel.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/4/25.
//

import Foundation


@MainActor
class ViewModel: ObservableObject {
    @Published var trendingMovies: [Movie] = []
    @Published var favorites: [Movie] = []
    var timeWindow: String = "day" {
        didSet {
            Task {
                await fetchMovies()
            }
        }
    }

    func fetchMovies() async {
        let downloadedMovies: [Movie]? = await TMDBAPICaller().getTrendingMovieList(timeWindow: self.timeWindow)
        trendingMovies = downloadedMovies ?? []
        //print(trendingMovies)
    }
    
    func toggleFavorite(_ movie: Movie) {
        if let index = favorites.firstIndex(where: { $0.id == movie.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(movie)
        }
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        favorites.contains(where: { $0.id == movie.id })
    }

    func removeFavorite(_ movie: Movie) {
        favorites.removeAll { $0.id == movie.id }
    }
}
