//
//  HomeView.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeMovieViewModel: HomeMovieViewModel
    @State private var searchText: String = ""
    @EnvironmentObject private var coordinator: Coordinator
    @State private var isMovieLoaded: Bool = false
    
    var body: some View {
        ZStack {
            Color("PrimaryColor").ignoresSafeArea()
            GeometryReader { geo in
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            coordinator.push(page: .searchMovie)
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray).padding(4)
                        }.buttonStyle(.borderedProminent)
                            .clipShape(.circle)
                            .tint(.white)
                            .foregroundStyle(.black)
                    }
                    ScrollView(showsIndicators: false){
                        NowPlaying(homeMovieViewModel: homeMovieViewModel)
                            .onAppear {
                                self.homeMovieViewModel.getNowPlayingMovie(page: 1)
                            }
                            .onAppear {
                                if isMovieLoaded == false {
                                    self.homeMovieViewModel.getNowPlayingMovie(page: 1)
                                    self.isMovieLoaded = true
                                }
                            }
                    }
                }.padding(10).frame(maxWidth: geo.size.width, maxHeight:  geo.size.height)
            }
        }
    }
}

struct NowPlaying: View {
    @ObservedObject var homeMovieViewModel: HomeMovieViewModel
    @EnvironmentObject private var coordinator: Coordinator
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Now Playing")
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.system(size: 20, weight: .semibold))
            .padding(.bottom, 12)
            if homeMovieViewModel.nowPlayingLoadingState {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0..<9, id: \.self) { _ in
                            HomeMovieListItem(isSkeleton: true)
                                .frame(height: 200)
                        }
                    }
                    .padding(.horizontal, 10)
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(homeMovieViewModel.movieNowPlayingResultsModel, id: \.id) { movie in
                            HomeMovieListItem(
                                movieImage: movie.posterPath,
                                movieRatings: movie.voteAverage,
                                movieTitle: movie.title
                            )
                            .frame(height: 200).onTapGesture {
                                coordinator.push(page: .detailMovie(movieId: movie.id))
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
        .padding(.bottom, 24)
    }
}




