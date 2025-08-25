//
//  SearchMovieDataSource.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 25/08/25.
//

import Combine
import Alamofire
import SwiftyJSON

protocol SearchMovieDataSourceProtocol {
    func fetchSearchMovies(query: String, page: Int) -> AnyPublisher<[MoviesResultResponse], Error>
}

class SearchMovieDataSource {
    static let searchMovieDataSource = SearchMovieDataSource()
}

extension SearchMovieDataSource: SearchMovieDataSourceProtocol {
    
    func fetchSearchMovies(query: String, page: Int) -> AnyPublisher<[MoviesResultResponse], any Error> {
        let endpoint = Endpoints.Gets.searchMovie(query: query, page: page)
        let url = endpoint.url
        let headers = APICall.headers
        
        return Future<[MoviesResultResponse], Error> { completion in
            AF.request(url, method: .get, headers: headers).validate().responseData { response in
                switch response.result {
                case .success(let movieData):
                    let searchMovie = JSON(movieData)
                    let searchMovieResponse = MoviesResponse(json: searchMovie)
                    completion(.success(searchMovieResponse.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
