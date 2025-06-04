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
    let movie: TrendingMovie

    var body: some View {
        ScrollView {
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

                if !movie.genreIds.isEmpty {
                    Text("Genres: \(movie.genreIds.map { String($0) }.joined(separator: ", "))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                }
                
                Text("\(movie.releaseDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}
