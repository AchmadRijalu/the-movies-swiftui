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
    private let remote: HomeMovieRemoteDataSourceProtocol
    private let locale: HomeMovieLocaleDataSourceProtocol
    
    init(remote: HomeMovieRemoteDataSourceProtocol = HomeMovieRemoteDataSource.homeMovieDataSource, locale: HomeMovieLocaleDataSource = HomeMovieLocaleDataSource()) {
        self.remote = remote
        self.locale = locale
    }
}

extension HomeMovieRepository: HomeMovieRepositoryProtocol {
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[HomeMovieModel], Error> {
        
        let localData = self.locale.getNowPlayingMovies()
            .map { movieEntities in
                movieEntities.map { data in
                    HomeMovieModel(
                        id: data.id,
                        posterPath: data.posterPath ?? "",
                        title: data.title,
                        voteAverage: data.voteAverage
                    )
                }
            }
            .eraseToAnyPublisher()
        
        let remoteData = self.remote.getNowPlayingMovies(page: page)
            .flatMap { movieResponse -> AnyPublisher<[MovieEntity], Error> in
                let entities = movieResponse.map { data -> MovieEntity in
                    let movieEntity = MovieEntity()
                    movieEntity.id = data.id
                    movieEntity.title = data.title
                    movieEntity.posterPath = data.posterPath
                    movieEntity.releaseDate = data.releaseDate
                    movieEntity.voteAverage = data.voteAverage
                    return movieEntity
                }
                return self.locale.addNowPlayingMovies(from: entities)
                    .flatMap { _ in self.locale.getNowPlayingMovies() }
                    .eraseToAnyPublisher()
            }
            .map { movieEntities in
                movieEntities.map { data in
                    HomeMovieModel(
                        id: data.id,
                        posterPath: data.posterPath ?? "",
                        title: data.title,
                        voteAverage: data.voteAverage
                    )
                }
            }
            .eraseToAnyPublisher()
        
        return localData
            .append(remoteData)
            .eraseToAnyPublisher()
    }
}
