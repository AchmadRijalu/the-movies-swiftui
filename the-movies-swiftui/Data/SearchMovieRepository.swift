//
//  SearchMovieRepository.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 25/08/25.
//

import Foundation
import Combine

protocol SearchMovieRepositoryProtocol {
    func fetchSearchMovies(query: String, page: Int) -> AnyPublisher<[SearchMovieModel], Error>
}

final class SearchMovieRepository: NSObject {
    private let remote: SearchMovieRemoteDataSourceProtocol
    
    init(remote: SearchMovieRemoteDataSourceProtocol = SearchMovieRemoteDataSource.searchMovieDataSource) {
        self.remote = remote
    }
}

extension SearchMovieRepository: SearchMovieRepositoryProtocol {
    func fetchSearchMovies(query: String, page: Int) -> AnyPublisher<[SearchMovieModel], Error> {
        return remote.fetchSearchMovies(query: query, page: page).map({ searchMovieResponse in
            let data = searchMovieResponse.map { data in
                SearchMovieModel(id: data.id, posterPath: data.posterPath ?? "", title: data.title, voteAverage: data.voteAverage)
            }
            return data
        }).eraseToAnyPublisher()
    }
}
