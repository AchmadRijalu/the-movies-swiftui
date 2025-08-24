//
//  DetailMovieResponse.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import Foundation
import SwiftyJSON

struct DetailMovieResponse {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let runtime: Int
    let voteAverage: Double
    let voteCount: Int
    let posterPath: String?
    let backdropPath: String?
    let tagline: String?
    let homepage: String?
    let budget: Int
    let revenue: Int
    let status: String
    let isAdult: Bool
    let genres: [GenreResultResponse]
    let productionCompanies: [ProductionCompanyResponse]
}

extension DetailMovieResponse {
    init(json: JSON) {
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.originalTitle = json["original_title"].stringValue
        self.overview = json["overview"].stringValue
        self.releaseDate = json["release_date"].stringValue
        self.runtime = json["runtime"].intValue
        self.voteAverage = json["vote_average"].doubleValue
        self.voteCount = json["vote_count"].intValue
        self.posterPath = json["poster_path"].string
        self.backdropPath = json["backdrop_path"].string
        self.tagline = json["tagline"].string
        self.homepage = json["homepage"].string
        self.budget = json["budget"].intValue
        self.revenue = json["revenue"].intValue
        self.status = json["status"].stringValue
        self.isAdult = json["adult"].boolValue
        
        self.genres = json["genres"].arrayValue.map { GenreResultResponse(json: $0) }
        self.productionCompanies = json["production_companies"].arrayValue.map { ProductionCompanyResponse(json: $0) }
    }
}
