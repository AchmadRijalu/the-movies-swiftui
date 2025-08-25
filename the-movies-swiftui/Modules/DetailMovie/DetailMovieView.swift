//
//  DetailMovieView.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI
import Combine
import Kingfisher
import SkeletonUI

struct DetailMovieView: View {
    @State var isFavorite: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State private var isShowMovieWebsite = false
    @ObservedObject var detailMovieViewModel: DetailMovieViewModel
    @State private var selectedContent: DetailMovieContent = .movieInfo
    @State private var isDetailMovieInfoLoaded: Bool = false
    @State private var isDetailMovieReviewsLoaded: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("PrimaryColor")
                VStack {
                    MovieVideoHeaderView(
                        detailMovieViewModel: detailMovieViewModel,
                    ) {
                        dismiss()
                    }
                    Picker("Content", selection: $selectedContent) {
                        ForEach(DetailMovieContent.allCases) { content in
                            Text(content.title).tag(content)
                        }
                    }
                    .pickerStyle(.segmented).padding(.bottom, 24).padding(.horizontal, 24)
                    switch selectedContent {
                    case .movieInfo:
                        DetailMovieInfoSection(detailMovieViewModel: detailMovieViewModel, isShowMovieWebsite: $isShowMovieWebsite)
                        .onAppear {
                            if isDetailMovieInfoLoaded == false {
                                detailMovieViewModel.getDetailMovie()
                                self.isDetailMovieInfoLoaded = true
                            }
                        }
                    case .movieReview:
                        VStack {
                            DetailMovieReviewSection(detailMovieViewModel: detailMovieViewModel).padding(.horizontal)
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                            .onAppear {
                                if isDetailMovieReviewsLoaded == false {
                                    detailMovieViewModel.getDetailMovieReviews(movieId: detailMovieViewModel.movieId)
                                    self.isDetailMovieReviewsLoaded = true
                                }
                            }
                    }
                }
            }.sheet(isPresented: $isShowMovieWebsite, content: {
                VStack {
                    HStack {
                        Image(systemName: "chevron.backward").foregroundColor(.white).padding(.leading, 12)
                        Text("Back").font(.system(.title3)).foregroundColor(.white).onTapGesture {
                            isShowMovieWebsite.toggle()
                        }
                        Spacer()
                    }.padding(.top, 8)
                    MovieWebPage(urlString: detailMovieViewModel.detailMovieModel?.homePageLink ?? "")
                }.background(Color("PrimaryColor"))
                
            })
            .ignoresSafeArea()
        }.background(Color("PrimaryColor")).navigationBarBackButtonHidden(true)
    }
}

struct MovieVideoHeaderView: View {
    @ObservedObject var detailMovieViewModel: DetailMovieViewModel
    var dismissAction: () -> Void

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                KFImage.url(
                  URL(string: Endpoints.Gets.image(
                    imageFilePath: detailMovieViewModel.detailMovieModel?.backdropPath ?? ""
                  ).url)
                )
                .resizable()
                .frame(maxWidth: .infinity)
                .skeleton(with: detailMovieViewModel.loadingState, shape: .rectangle)
                HStack {
                    Button(action: dismissAction) {
                        Image(systemName: "chevron.backward")
                    }
                    .buttonStyle(.borderedProminent)
                    .clipShape(.circle)
                    .tint(.white)
                    .foregroundStyle(.black)
                    .padding()
                    .padding(.top, 32)

                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 240)
        .background(.clear)
        .padding(.bottom, 12)
    }
}

#Preview {}
