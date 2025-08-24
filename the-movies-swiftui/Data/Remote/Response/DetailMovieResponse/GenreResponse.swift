//
//  GenreResponse.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftyJSON

struct GenreResponse: Codable {
    let genres: [GenreResultResponse]
    init(json: JSON) {
        self.genres = json["genres"].arrayValue.compactMap(GenreResultResponse.init)
    }
}

struct GenreResultResponse: Codable {
    let id: Int
    let name: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}
