//
//  FavoritesView.swift
//  MovieInfo
//
//  Created by Rishabh Ganesh on 6/4/25.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.favorites) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie).environmentObject(viewModel)) {
                        HStack {
                            Button(action: {
                                viewModel.removeFavorite(movie)
                            }) {
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                            Text(movie.title)
                            Spacer()
                            
                            Image(systemName: viewModel.isFavorite(movie) ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
    }
}
