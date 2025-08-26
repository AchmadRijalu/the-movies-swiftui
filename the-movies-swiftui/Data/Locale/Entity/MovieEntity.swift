//
//  ListItem.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 26/08/25.
//

import RealmSwift
import Foundation

class MovieEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String?
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var releaseDate: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
