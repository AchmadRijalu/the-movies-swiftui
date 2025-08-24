//
//  Router.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .homeMovie)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { item in
                    coordinator.buildCover(cover: item)
                }
        }
        .environmentObject(coordinator)
    }
}
