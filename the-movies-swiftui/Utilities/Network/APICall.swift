//
//  APICall.swift
//  CineBlix
//
//  Created by Achmad Rijalu on 30/11/23.
//

import Foundation
import Alamofire

struct APICall{
    static let baseUrl = "https://api.themoviedb.org/3/movie"
    static let baseImageUrl = "https://image.tmdb.org/t/p/w500"
    static var apiKey: String {
        return "d2aa1285de7e6ebda80b77de81c67b01"
    }
    
    static var headers: HTTPHeaders {
        return ["Accept": "application/json"]
    }
}

protocol Endpoint {
    var url: String {get}
}

enum Endpoints {
    enum Gets: Endpoint {
        case movieNowPlaying(page: Int)
        case movieInfo(movieId: Int)
        case movieReview(movieId: Int)
        case image(imageFilePath: String)
        case searchMovie(query: String, page: Int)
        
        var url: String {
            switch self {
            case .movieNowPlaying(let page):
                return "\(APICall.baseUrl)/now_playing?api_key=\(APICall.apiKey)&page=\(page)"
            case .movieInfo(let movieId):
                return "\(APICall.baseUrl)/\(movieId)?api_key=\(APICall.apiKey)"
            case .image(let imageFilePath):
                return "\(APICall.baseImageUrl)/\(imageFilePath)"
            case .movieReview(movieId: let movieId):
                return "\(APICall.baseUrl)/\(movieId)/reviews?api_key=\(APICall.apiKey)"
            case .searchMovie(query: let query, page: let page):
                let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
                return "\(APICall.baseUrl)/search/movie?api_key=\(APICall.apiKey)&query=\(encodedQuery)&page=\(page)"
            }
        }
    }
}
