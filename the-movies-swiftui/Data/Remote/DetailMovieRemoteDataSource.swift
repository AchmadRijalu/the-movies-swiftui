//
//  DetailMovieRepository.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import Alamofire
import Combine
import SwiftyJSON

protocol DetailMovieRemoteDataSourceProtocol {
    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieResponse, Error>
    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<DetailMovieReviewResponse, Error>
}

class DetailMovieRemoteDataSource {
    static let detailMovieDataSource = DetailMovieRemoteDataSource()
}

extension DetailMovieRemoteDataSource: DetailMovieRemoteDataSourceProtocol {
    func getDetailMovieInfo(movieId: Int) -> AnyPublisher<DetailMovieResponse, any Error> {
        let endpoint = Endpoints.Gets.movieInfo(movieId: movieId)
        let url = endpoint.url
        let headers = APICall.headers
        return Future<DetailMovieResponse, Error> { completion in
            AF.request(url, method: .get, headers: headers).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    let responseData = JSON(data)
                    let detailMovieResponse = DetailMovieResponse(json: responseData)
                    completion(.success(detailMovieResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getDetailMovieReviews(movieId: Int) -> AnyPublisher<DetailMovieReviewResponse, any Error> {
        let endpoint = Endpoints.Gets.movieReview(movieId: movieId)
        let url = endpoint.url
        let headers = APICall.headers
        
        return Future<DetailMovieReviewResponse, Error> { completion in
            AF.request(url, method: .get, headers: headers).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    let responseData = JSON(data)
                    let detailMovieResponse = DetailMovieReviewResponse(json: responseData)
                    completion(.success(detailMovieResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
