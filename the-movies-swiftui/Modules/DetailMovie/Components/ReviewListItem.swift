//
//  ReviewListItem.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI

struct ReviewListItem: View {
    var detailMovieReviewModel: DetailMovieReviewModel
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text(detailMovieReviewModel.name).font(.system(size: 14, weight: .semibold))
                Spacer()
                HStack {
                    Image(systemName: "star.fill")
                    Text(String(detailMovieReviewModel.rating)).font(.system(size: 14, weight: .regular))
                }
            }
            Text(detailMovieReviewModel.content).font(.system(size: 12, weight: .regular))
        }.foregroundColor(Color("SecondaryColor"))
    }
}

#Preview {
    ReviewListItem(detailMovieReviewModel: DetailMovieReviewModel(name: "Upin ipin", rating: 9.10, content: ""))
}
