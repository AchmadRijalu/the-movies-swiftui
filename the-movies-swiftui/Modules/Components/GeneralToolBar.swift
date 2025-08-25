//
//  GeneralToolbar.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 24/08/25.
//

import SwiftUI

struct GeneralToolBar: View {
    var action: () -> Void = {}
    var title: String = "Favorite"

    var body: some View {
        ZStack {
            HStack {
                Button {
                    action()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("SecondaryColor"))
                }
                Spacer()
            }
            Text(title)
                .foregroundStyle(Color("SecondaryColor"))
                .font(.system(size: 17, weight: .semibold))
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: 55)
        .background(Color("PrimaryColor"))
    }
}

#Preview {
    GeneralToolBar()
}
