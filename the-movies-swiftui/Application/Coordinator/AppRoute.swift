//
//  AppRoute.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI

enum AppPages: Hashable {
    case homeMovie
    case detailMovie(movieId: Int)
}

enum FullScreenCover: String, Identifiable {
    var id: String {
        self.rawValue
    }
    case searchMovie
}
