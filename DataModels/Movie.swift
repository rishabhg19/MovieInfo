//
//  Movie.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/3/25.
//

struct TrendingMovie: Codable, Identifiable {
    let id: Int;
    let title: String;
    let rating: Float;
    let releaseDate: String;
    let overview: String;
    let imgPath: String; //poster_path
    let genreIds: [Int];
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case rating = "vote_average"
        case releaseDate = "release_date"
        case imgPath = "poster_path"
        case genreIds = "genre_ids"
    }
    
}

struct TrendingMovieResponse: Codable {
    let results: [TrendingMovie]
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct MovieDetail: Codable {
    let id: Int
    let title: String
    let overview: String
    let rating: Float
    let genres: [Genre]
    let runtime: Int
    let originCountry: [String]

    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, runtime
        case rating = "vote_average"
        case originCountry = "origin_country"
    }
}
