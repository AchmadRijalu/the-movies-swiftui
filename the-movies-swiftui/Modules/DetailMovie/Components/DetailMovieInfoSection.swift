//
//  DetailMovieInfoSection.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct DetailMovieInfoSection: View {
    
    @ObservedObject var detailMovieViewModel: DetailMovieViewModel
    @Binding var isShowMovieWebsite: Bool
    var body: some View {
        ScrollView {
            HStack( content: {
                VStack {
                    KFImage.url(URL(string:Endpoints.Gets.image(imageFilePath: detailMovieViewModel.detailMovieModel?.posterPath ?? "").url))
                        .placeholder {
                        Image("empty.image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 140)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                        .resizable()
                        .frame(width: 100, height: 140)
                        .scaledToFill()
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .skeleton(with: detailMovieViewModel.loadingState, size: CGSize(width: 100, height: 140),
                                  appearance: .solid(color: .gray,background: .gray),
                                  shape: .rounded(.radius(12, style: .circular)))
                }
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(detailMovieViewModel.detailMovieModel?.title ?? "Movie Title")
                            .font(Font.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                            .multilineTextAlignment(.leading)
                            .skeleton(
                                with: detailMovieViewModel.loadingState,
                                appearance: .solid(color: .gray, background: .gray),
                                shape: .rectangle
                            )
                        Spacer()
                    }
                    HStack(spacing: 12) {
                        Text("Genres:")
                            .font(.subheadline)
                            .frame(alignment: .leading)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                if detailMovieViewModel.loadingState {
                                    ForEach(0..<3, id: \.self) { _ in
                                        Text("Genre")
                                            .font(.caption)
                                            .padding(6)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(8)
                                            .skeleton(
                                                with: true,
                                                animation: .pulse(duration: 0.5, delay: 0.4, speed: 0.5, autoreverses: true),
                                                shape: .rounded(.radius(8)),
                                                lines: 0
                                            )
                                    }
                                } else {
                                    ForEach(detailMovieViewModel.detailMovieModel?.genres ?? [], id: \.self) { genre in
                                        Text(genre)
                                            .font(.caption)
                                            .padding(6)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(8).lineLimit(0)
                                    }
                                }
                            }
                        }
                    }
                    HStack(spacing: 12){
                        Text("Release:")
                            .font(.subheadline)
                            .frame(minWidth: 0, alignment: .leading)
                        Text(detailMovieViewModel.detailMovieModel?.releaseDate ?? "")
                            .font(.subheadline)
                            .frame(minWidth: 0, alignment: .leading)
                            .skeleton(
                                with:
                                    detailMovieViewModel.loadingState,
                                appearance: .solid(color: .gray, background: .gray, ), shape: .rectangle)
                    }
                    HStack(spacing: 12){
                        Text("Duration:")
                            .font(.subheadline)
                        Text(detailMovieViewModel.convertToHoursFromMinutes(detailMovieViewModel.detailMovieModel?.runTime ?? 120))
                            .skeleton(
                                with: detailMovieViewModel.loadingState,
                                appearance: .solid(color: .gray, background: .gray),
                                shape: .rectangle
                            )
                    }
                }
                .foregroundColor(Color("SecondaryColor"))
            }).padding(.horizontal, 20).padding(.bottom, 16)
            GeneralButton(action: {
                isShowMovieWebsite.toggle()
            }, content: {
                HStack {
                    Image(systemName: "globe")
                    Text("Visit Official Website")
                }
            }, color: .red)
            .skeleton(
                with: detailMovieViewModel.loadingState,
                size: CGSize(width: 200, height: 40),
                shape: .capsule,
            )
            
            VStack {
                HStack{
                    Text("Overview")
                        .foregroundStyle(.white)
                        .font(Font.system(size: 22, weight: .medium))
                    Spacer()
                }.padding(.top, 12).padding(.bottom, 4).padding(.leading, 4)
                
                Text(detailMovieViewModel.detailMovieModel?.overview ?? "")
                    .foregroundStyle(Color("SecondaryColor"))
                    .font(.subheadline).multilineTextAlignment(.leading)
                    .skeleton(
                        with: detailMovieViewModel.loadingState,
                        animation: .pulse(duration: 0.5, delay: 0.9, speed: 0.5, autoreverses: true),
                        shape: .rectangle,
                        lines: 3
                    )
            }.padding(.horizontal, 12)
            
            VStack {
                HStack{
                    Text("Production Companies")
                        .foregroundStyle(.white)
                        .font(Font.system(size: 22, weight: .medium))
                    Spacer()
                }.padding(.top, 12).padding(.leading, 4)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center, spacing: 20) {
                        ForEach(detailMovieViewModel.detailMovieModel?.productionCompanies ?? [], id: \.self) { company in
                            CompanyListItem(companyImage: company.posterPath, companyName: company.name, companyCountry: company.originCountry)
                        }
                    }
                }
            }.padding(.horizontal, 12)
        }
    }
}
