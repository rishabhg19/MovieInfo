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

    func fetchMovieDetail(id: Int) async {
        movieDetail = await TMDBAPICaller().getMovieDetails(id: id)
        print(movieDetail)
    }
}
