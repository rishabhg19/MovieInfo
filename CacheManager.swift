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
    
    private var cacheDir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(cache.cacheFile)
    
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
