//
//  HomeViewModel.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI
import Combine


class HomeMovieViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var movieNowPlayingResultsModel: [HomeMovieModel] = []
    @Published var errorMessage: String = ""
    @Published var nowPlayingLoadingState: Bool = false
    
    private let repository: HomeMovieRepositoryProtocol
    
    init(repository: HomeMovieRepositoryProtocol = HomeMovieRepository()) {
        self.repository = repository
    }
    
    func getNowPlayingMovie(page: Int) {
        guard movieNowPlayingResultsModel.isEmpty else { return }
        nowPlayingLoadingState = true
        
        repository.getNowPlayingMovies(page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    self.nowPlayingLoadingState = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.nowPlayingLoadingState = false
                }
            } receiveValue: { [weak self] movies in
                self?.movieNowPlayingResultsModel = movies
            }
            .store(in: &cancellables)
    }
}

