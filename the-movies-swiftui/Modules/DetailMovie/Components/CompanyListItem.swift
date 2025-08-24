//
//  CompanyListItem.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI
import Kingfisher

struct CompanyListItem: View {
    var companyImage: String?
    var companyName: String?
    var companyCountry: String?
    var body: some View {
        VStack {
            VStack {
                KFImage.url(URL(string: Endpoints.Gets.image(imageFilePath: companyImage ?? "").url))
                    .resizable().aspectRatio(contentMode: .fit).frame(width: 100)
            }.padding().background(Color("WhiteColor")).clipped().clipShape(RoundedRectangle(cornerRadius: 12))
            Text(companyName).foregroundStyle(Color("SecondaryColor")).font(.subheadline).padding(.bottom, 4)
            Text(companyCountry).foregroundStyle(Color("SecondaryColor")).font(.caption).font(Font.system(size: 12, weight: .semibold))
        }.padding()
    }
}

#Preview {
    CompanyListItem(companyImage: "")
}
