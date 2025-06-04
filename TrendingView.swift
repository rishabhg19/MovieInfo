//
//  ContentView.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/3/25.
//



import Foundation
import SwiftUI
 
struct TrendingView: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                Text("Most Popular")
                    .padding()

                HStack {
                    Button("Today") {
                        viewModel.timeWindow = "day"
                    }
                    .padding()
                    .background(viewModel.timeWindow == "day" ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .frame(width: 100, height: 60)

                    Button("This week") {
                        viewModel.timeWindow = "week"
                    }
                    .padding()
                    .background(viewModel.timeWindow == "week" ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .frame(width: 140, height: 60)
                }
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.trendingMovies) { movie in
                        ZStack(alignment: .topTrailing) {
                            // Entire card navigates on tap
                            NavigationLink(destination: MovieDetailView(movie: movie).environmentObject(viewModel)) {
                                VStack(alignment: .leading) {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(movie.imgPath)")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 240, height: 360)
                                            .clipped()
                                            .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 240, height: 360)
                                    }

                                    Text(movie.title)
                                        .font(.caption)
                                        .lineLimit(1)
                                    Text("⭐️ \(String(format: "%.1f", movie.rating))")
                                        .font(.caption)
                                        .lineLimit(1)
                                }
                                .frame(width: 240)
                                .background(Color.clear)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())

                            Button(action: {
                                viewModel.toggleFavorite(movie)
                            }) {
                                Image(systemName: viewModel.isFavorite(movie) ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                                    .padding(8)
                                    .background(Color.white.opacity(0.75))
                                    .clipShape(Circle())
                            }
                            .padding(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .task {
            await viewModel.fetchMovies()
        }
    }
}
