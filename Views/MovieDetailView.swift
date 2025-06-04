//
//  MovieDetailView.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/4/25.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    @StateObject private var detailModel = MovieDetailModel()
    let movie: TrendingMovie

    var body: some View {
        ScrollView {
            if let movieDetail = detailModel.movieDetail {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.imgPath)")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                                .frame(height: 300)
                        }
                        
                        Button(action: {
                            viewModel.toggleFavorite(movie)
                        }) {
                            Image(systemName: viewModel.isFavorite(movie) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .padding()
                                .background(Color.white.opacity(0.75))
                                .clipShape(Circle())
                        }
                        .padding()
                    }
                    
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Overview")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    Text(movie.overview)
                        .font(.body)
                    
                    Text("\(movie.releaseDate)")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    if !movieDetail.genres.isEmpty {
                        Text("(\(movieDetail.originCountry[0])) \(movieDetail.genres.map { $0.name }.joined(separator: ", "))")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    
                    Text("\(movieDetail.runtime / 60)h \(movieDetail.runtime % 60)m")
                        .font(.body)
                    
                }.padding()
            }
        }
        .onAppear {
            Task {
                await detailModel.fetchMovieDetail(id: movie.id)
            }
        }

        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
    }

}
