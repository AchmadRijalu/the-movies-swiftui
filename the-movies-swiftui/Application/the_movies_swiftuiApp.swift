//
//  the_movies_swiftuiApp.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI
import netfox

@main
struct the_movies_swiftuiApp: App {
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView().colorScheme(.dark).onAppear {
                NFX.sharedInstance().start()
            }
        }
    }
}
