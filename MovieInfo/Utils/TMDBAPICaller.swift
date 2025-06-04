//
//  GETRequest.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/3/25.
//

import Foundation


class TMDBAPICaller {
    let token = Bundle.main.infoDictionary?["TMDBReadToken"] as? String
    //below is a fake read access token
    //let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJleGFtcGxlLmNvbSIsImF1ZCI6IjEyMzQ1Njc4OTBhYmNkZWYiLCJzdWIiOiJhYmNkZWZnaGlqa2xtbm9wcXJzdHV2Iiwic2NvcGVzIjpbInJlYWQiLCJ3cml0ZSJdLCJpYXQiOjE2NDAwMDAwMDB9.XyZ1vK8mNxlPBoR7S5TR0jdXQqztAaWM0j_Hq8RlJhA"
    
    func getTrendingMovieList(timeWindow: String = "day") async -> [TrendingMovie]? {
        //print("token is \(token)")
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/\(timeWindow)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(token ?? "")"
        ]
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
            return decodedData.results
        } catch(let error) {
            print("API error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getMovieDetails(id: Int) async -> MovieDetail? {

        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id.description)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "include_adult", value: "false"),
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(token ?? "")"
        ]
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(MovieDetail.self, from: data)
            return decodedData
        } catch(let error) {
            print("API error: \(error.localizedDescription)")
            return nil
        }
    }
}
