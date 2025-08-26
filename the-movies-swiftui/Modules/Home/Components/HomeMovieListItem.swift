//
//  HomeMovieListItem.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct HomeMovieListItem: View {
    var movieImage: String?
    var movieRatings: Double?
    var movieTitle: String?
    var isSkeleton: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                if isSkeleton {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .skeleton(
                            with: true,
                            size: CGSize(width: 116, height: 160),
                            animation: .pulse(
                                duration: 0.8,
                                delay: 0.2,
                                speed: 0.8,
                                autoreverses: true
                            ),
                            appearance: .solid(color: .gray, background: .white),
                            shape: .rounded(.radius(12, style: .circular))
                        )
                } else {
                    KFImage(URL(string: Endpoints.Gets.image(imageFilePath: movieImage ?? "").url))
                        .placeholder {
                            Image("empty.image")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 116, height: 160)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .cacheOriginalImage()
                        .resizable()
                        .scaledToFill()
                        .frame(width: 116, height: 160)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Text("MovieDb \(String(format: "%.1f", movieRatings ?? 0))")
                        .font(.system(size: 10))
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.black.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .padding(6)
                        .offset(x: 25, y: -50)
                }
            }
            .padding(.bottom, 4)
            HStack {
                if isSkeleton {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 80, height: 12)
                        .skeleton(with: true)
                } else {
                    Text(movieTitle ?? "")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .padding(.leading, 8)
                }
                Spacer()
            }
        }
        .frame(width: 116)
    }
}

#Preview {
    HomeMovieListItem()
}
