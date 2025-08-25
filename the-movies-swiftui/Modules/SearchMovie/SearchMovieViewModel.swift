//
//  SearchMovieViewModel.swift
//  the-movies-swiftui
//
//  Created by Achmad Rijalu on 23/08/25.
//

import SwiftUI
import Combine

class SearchMovieViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    @Published var searchMovieList: [SearchMovieModel] = []
    @Published var querySearch: String = ""
    @Published var errorMessage: String = ""
    @Published var nowPlayingLoadingState: Bool = false
    private let repository: SearchMovieRepositoryProtocol
    
    init(repository: SearchMovieRepositoryProtocol = SearchMovieRepository()) {
        self.repository = repository
        self.fetchQueryMovies()
    }
    
    func fetchSearchMovie(query: String, page: Int = 1) {
        searchMovieList.removeAll()
        errorMessage = ""
        nowPlayingLoadingState = true
        
        repository.fetchSearchMovies(query: query, page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.nowPlayingLoadingState = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] searchMovieData in
                self?.searchMovieList = searchMovieData
            }
            .store(in: &cancellables)
    }
}

extension SearchMovieViewModel {
    func fetchQueryMovies() {
        $querySearch.debounce(for: .milliseconds(500), scheduler: RunLoop.main).removeDuplicates().sink { [weak self]  queryData in
            guard let self = self else {return}
            if queryData.isEmpty {
                self.searchMovieList = []
            }
            else {
                self.fetchSearchMovie(query: queryData)
            }
        }.store(in: &cancellables)
    }
}
