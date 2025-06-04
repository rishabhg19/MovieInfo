//
//  CacheManager.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/4/25.
//

import Foundation

class CacheManager {
    static let cache = CacheManager()
    private init() {}
    private let cacheFile: String = "movieCache.json"
    private var cacheDir: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(cacheFile)
    }
    private func getTrendingMovieCacheDir(filename: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }
    
    //trendingMovies_day.json and trendingMovies_week.json
    func writeTrendingCache(_ movies: [TrendingMovie], timeWindow: String) {
        let filename = "trendingMovies_\(timeWindow).json"
        let url = getTrendingMovieCacheDir(filename: filename)
        
        do {
            let data = try JSONEncoder().encode(movies)
            try data.write(to: url)
        } catch {
            print("Failed to write trending movie cache: \(error)")
        }
    }
    
    func readTrendingCache(timeWindow: String) -> [TrendingMovie] {
        let filename = "trendingMovies_\(timeWindow).json"
        let url = getTrendingMovieCacheDir(filename: filename)
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([TrendingMovie].self, from: data)
        } catch {
            print("Error while reading trending movie cache: \(error)")
            return []
        }
    }
    
    func writeCache(movieDetails: [Int: MovieDetail]) {
        do {
            let data = try JSONEncoder().encode(movieDetails)
            try data.write(to: cacheDir)
        } catch {
            print("Error writing to cache: \(error)")
        }
    }

    func readCache() -> [Int: MovieDetail] {
        do {
            let data = try Data(contentsOf: cacheDir)
            return try JSONDecoder().decode([Int: MovieDetail].self, from: data)
        } catch {
            print("Failed to read cache: \(error)")
            return [:]
        }
    }
    
}
