//
//  HomeModel.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import Foundation

struct HomeMovieModel: Equatable, Identifiable {
    let id: Int
    let posterPath: String
    var title: String
    let voteAverage: Double
}
