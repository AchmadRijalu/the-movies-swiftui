//
//  SearchMovieView.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI

struct SearchMovieView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""
    @ObservedObject var searchViewModel: SearchMovieViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State private var debounceText: String = ""
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)
    var body: some View {
        VStack {
            GeneralToolBar(action: {
                dismiss()
                searchViewModel.querySearch = ""
            }, title: "Search Movie")
            GeometryReader { geo in
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("", text: $searchViewModel.querySearch, prompt: Text("Search Movies").foregroundColor(.gray)).textFieldStyle(.plain)
                    }
                    .padding(10)
                    .background(Color("SecondaryColor"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .foregroundColor(.black).padding(.vertical, 12)
                    
                    ScrollView(showsIndicators: false) {
                        if searchViewModel.nowPlayingLoadingState {
                            ProgressView().tint(Color("PrimaryColor"))
                        }
                        else {
                            LazyVGrid(columns: columns) {
                                ForEach(searchViewModel.searchMovieList, id: \.id) { searchMovie in
                                    HomeMovieListItem(
                                        movieImage: searchMovie.posterPath,
                                        movieRatings: searchMovie.voteAverage,
                                        movieTitle: searchMovie.title
                                    )
                                    .frame(height: 200).onTapGesture {
                                        coordinator.push(page: .detailMovie(movieId: searchMovie.id))
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                }
            }
        }.background(.white)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SearchMovieView(searchViewModel: SearchMovieViewModel())
}
