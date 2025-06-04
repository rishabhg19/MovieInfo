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
    
    
}
