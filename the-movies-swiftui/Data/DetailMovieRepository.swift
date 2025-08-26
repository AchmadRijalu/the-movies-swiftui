//
//  DetailMovieRepository.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 24/08/25.
//

import Foundation
import Combine

protocol DetailMovieRepositoryProtocol {
    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieModel, Error>
    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<[DetailMovieReviewModel], Error>
}

final class DetailMovieRepository: NSObject {
    private let remote: DetailMovieRemoteDataSourceProtocol
    
    init(remote: DetailMovieRemoteDataSourceProtocol = DetailMovieRemoteDataSource.detailMovieDataSource) {
        self.remote = remote
    }
}

extension DetailMovieRepository: DetailMovieRepositoryProtocol {
    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieModel, any Error> {
        return remote.getDetailMovieInfo(movieId: movieId).map { detailMovieResponse in
            let data: DetailMovieModel = DetailMovieModel(title: detailMovieResponse.title, overview: detailMovieResponse.overview, backdropPath: detailMovieResponse.backdropPath ?? "", posterPath: detailMovieResponse.posterPath ?? "", releaseDate: detailMovieResponse.releaseDate, voteAverage: detailMovieResponse.voteAverage, homePageLink: detailMovieResponse.homepage ?? "", genres: detailMovieResponse.genres.map({
                $0.name
            }), runTime: detailMovieResponse.runtime, productionCompanies: detailMovieResponse.productionCompanies.map({
                DetailMovieProductionCompanies(name: $0.name, posterPath: $0.logoPath, originCountry: $0.originCountry)
            }))
            return data
        }.eraseToAnyPublisher()
    }
    
    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<[DetailMovieReviewModel], any Error> {
        return remote.getDetailMovieReviews(movieId: movieId).map { detailMovieReview in
            let results = detailMovieReview.results
            return results.map {
                DetailMovieReviewModel(name: $0.author, rating: $0.rating ?? 0, content: $0.content)
            }
        }.eraseToAnyPublisher()
    }
}
