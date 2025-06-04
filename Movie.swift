//
//  Movie.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/3/25.
//
struct Movie: Codable, Identifiable {
    let id: Int;
    let title: String;
    let rating: Float;
    let releaseDate: String;
    let overview: String;
    let imgPath: String; //poster_path
    let genreIds: [Int];
    let runtime: Int?;
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime
        case rating = "vote_average"
        case releaseDate = "release_date"
        case imgPath = "poster_path"
        case genreIds = "genre_ids"
    }
    
}

struct MovieResponse: Codable {
    let results: [Movie]
}
