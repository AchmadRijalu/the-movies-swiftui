//
//  HomeMovieRepository.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import Foundation
import Combine

protocol HomeMovieRepositoryProtocol {
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[HomeMovieModel], Error>
}

final class HomeMovieRepository: NSObject {
    private let remote: HomeMovieDataSourceProtocol
    
    init(remote: HomeMovieDataSourceProtocol = HomeMovieDataSource.homeMovieDataSource) {
        self.remote = remote
    }
}

extension HomeMovieRepository: HomeMovieRepositoryProtocol {
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[HomeMovieModel], Error> {
        return remote.getNowPlayingMovies(page: page).map({ movieListResponse in
            let data = movieListResponse.map { data in
                HomeMovieModel(id: data.id, posterPath: data.posterPath ?? "", title: data.title, voteAverage: data.voteAverage)
            }
            return data
        }).eraseToAnyPublisher()
    }
}
