//
//  AppCoordinator.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    @Published var fullScreenCover: FullScreenCover?
    @Published var homeViewModel: HomeMovieViewModel = HomeMovieViewModel()
    @Published var searchViewModel: SearchMovieViewModel = SearchMovieViewModel()
    
    func push(page: AppPages) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func presentFullScreenCover(_ cover: FullScreenCover) {
        self.fullScreenCover = cover
    }
    
    func dismissCover() {
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .homeMovie:
            HomeView(homeMovieViewModel: homeViewModel)
        case .detailMovie(let movieId):
            let vm: DetailMovieViewModel = DetailMovieViewModel(movieId: movieId)
            DetailMovieView(detailMovieViewModel: vm)
        case .searchMovie:
            SearchMovieView(searchViewModel: searchViewModel)
        }
    }
    
    @ViewBuilder
    func buildCover(cover: FullScreenCover) -> some View {
        switch cover {
        case .searchMovie:
            SearchMovieView(searchViewModel: searchViewModel)
        }
    }
}
