//
//  HomeRepository.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import Combine
import Alamofire
import SwiftyJSON

protocol HomeMovieDataSourceProtocol {
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MoviesResultResponse], Error>
}

final class HomeMovieDataSource {
    static let homeMovieDataSource = HomeMovieDataSource()
}

extension HomeMovieDataSource: HomeMovieDataSourceProtocol {
    
    func getNowPlayingMovies(page: Int) -> AnyPublisher<[MoviesResultResponse], Error> {
        let endpoint = Endpoints.Gets.movieNowPlaying(page: page)
        let url = endpoint.url
        let header = APICall.headers
        return Future<[MoviesResultResponse], Error> { completion in
            AF.request(url, method: .get, headers: header).validate().responseData { response in
                switch response.result {
                case .success(let movieData):
                    let responseData = JSON(movieData)
                    let movieResponse = MoviesResponse(json: responseData)
                    let movieResults = movieResponse.results
                    completion(.success(movieResults))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
