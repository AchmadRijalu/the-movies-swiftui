//
//  CustomError+Ext.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 26/08/25.
//

import Foundation

enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }

}
