//
//  GETRequest.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/3/25.
//

import Foundation


class TMDBAPICaller {
    let token = Bundle.main.infoDictionary?["TMDBReadToken"] as? String
    
    func getTrendingMovieList(timeWindow: String = "day") async -> [Movie]? {
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
            let decodedData = try JSONDecoder().decode(MovieResponse.self, from: data)
            return decodedData.results
        } catch(let error) {
            print("API error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getMovieDetails(id: Int) async -> Movie? {

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
            print(String(decoding: data, as: UTF8.self))
            return nil
        } catch(let error) {
            print("API error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getGenreIds() async -> [String:Any] {
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en"),
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
            print(String(decoding: data, as: UTF8.self))
            return [:]
        } catch (let error) {
            print("API error: \(error.localizedDescription)")
            return [:]
        }
    }
}
