//
//  DetailViewModel.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//


import Foundation
import Combine
import SwiftUI
import SkeletonUI

enum DetailMovieContent: CaseIterable, Identifiable{
    var id: Self {self}
    case movieInfo
    case movieReview
    
    var title: String {
        switch self {
        case .movieInfo:
            return "Info"
        case .movieReview:
            return "Review"
        }
    }
}

class DetailMovieViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    let movieId: Int
    private let detailMovieRepository: DetailMovieRepositoryProtocol
    
    init(movieId: Int, detailMovieRepository: DetailMovieRepositoryProtocol = DetailMovieRepository()) {
        self.movieId = movieId
        self.detailMovieRepository = detailMovieRepository
    }
    
    @Published var detailMovieModel: DetailMovieModel?
    @Published var detailMovieReviewModel: [DetailMovieReviewModel]?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    func getDetailMovie() {
        loadingState = true
        detailMovieRepository.getDetailMovieInfo(movieId: movieId).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished:
                self.loadingState = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        } receiveValue: { response in
            self.detailMovieModel = response
        }.store(in: &cancellables)
    }
    
    func getDetailMovieReviews(movieId: Int) {
        loadingState = true
        detailMovieRepository.getDetailMovieReviews(movieId: movieId).receive(on: DispatchQueue.main).sink { completion in
            switch completion {
            case .finished:
                self.loadingState = false
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        } receiveValue: { response in
            self.detailMovieReviewModel = response
        }.store(in: &cancellables)
    }
}

extension DetailMovieViewModel {
    func convertToHoursFromMinutes(_ minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return "\(hours)h \(remainingMinutes)m"
    }
}
