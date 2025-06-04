//
//  MovieDetailModel.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/4/25.
//

import Foundation
@MainActor
class MovieDetailModel: ObservableObject {
    @Published var movieDetail: MovieDetail?
    private var cache: [Int: MovieDetail] = CacheManager.cache.readCache()

    func fetchMovieDetail(id: Int) async {
        if let cached = cache[id] {
            self.movieDetail = cached
            print("USING CACHE\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
            return
        }
        if let apiData = await TMDBAPICaller().getMovieDetails(id: id) {
            movieDetail = apiData
            cache[id] = apiData
            CacheManager.cache.writeCache(movieDetails: cache)
        }
    }
}
