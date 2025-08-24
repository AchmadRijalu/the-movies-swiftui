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
            let vm = HomeMovieViewModel()
            HomeView(homeMovieViewModel: vm)
        case .detailMovie(let movieId):
            let vm: DetailMovieViewModel = DetailMovieViewModel(movieId: movieId)
            DetailMovieView(detailMovieViewModel: vm)
        }
    }
    
    @ViewBuilder
    func buildCover(cover: FullScreenCover) -> some View {
        switch cover {
        case .searchMovie:
            SearchMovieView()
        }
    }
}
