//
//  SearchMovieModel.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import Foundation

struct SearchMovieModel: Equatable, Identifiable {
    let id: Int
    let posterPath: String
    var title: String
    let voteAverage: Double
}
