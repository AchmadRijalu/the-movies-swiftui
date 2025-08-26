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
    @Published var nowPlayingLoadingState: Bool = false
    private let repository: SearchMovieRepositoryProtocol
    
    init(repository: SearchMovieRepositoryProtocol = SearchMovieRepository()) {
        self.repository = repository
        self.fetchQueryMovies()
    }
    
    func fetchSearchMovie(query: String, page: Int = 1) {
        searchMovieList.removeAll()
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
                    self.presentGeneralError(errorMessage: error.localizedDescription)
                }
            } receiveValue: { [weak self] searchMovieData in
                self?.searchMovieList = searchMovieData
            }
            .store(in: &cancellables)
    }
    
    func presentGeneralError(errorMessage: String) {
         let bottomSheetTransitionDelegate = BottomSheetTransitionDelegate()
        let sheetVC = APIErrorBottomSheet(image: UIImage(systemName: "exclamationmark.triangle"), title: "Ooopss.", message: errorMessage)
        
        sheetVC.modalPresentationStyle = .custom
        sheetVC.transitioningDelegate = bottomSheetTransitionDelegate
        
        if let topVC = UIApplication.shared.topViewController() {
            topVC.present(sheetVC, animated: true)
        }
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
