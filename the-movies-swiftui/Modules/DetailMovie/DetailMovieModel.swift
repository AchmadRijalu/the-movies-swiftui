//
//  DetailMovieModel.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import Foundation

struct DetailMovieModel {
    let title: String
    let overview: String
    let backdropPath: String
    let posterPath: String
    let releaseDate: String
    let voteAverage:Double
    let homePageLink: String
    let genres: [String]
    let runTime: Int
    let productionCompanies: [DetailMovieProductionCompanies]
}

struct DetailMovieProductionCompanies: Hashable {
    var name: String
    var posterPath: String?
    var originCountry: String
}

struct DetailMovieReviewModel:Hashable, Identifiable, Equatable {
    var id = UUID()
    let name: String
    let rating: Double
    let content: String
}
