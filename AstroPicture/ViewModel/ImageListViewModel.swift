//
//  ImageListViewModel.swift
//  AstroPicture
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import Combine
import Foundation

class ImageListViewModel: ObservableObject {
    @Published var apods: [Apod] = []
    @Published var errorMessage: String?
    
    private let repository: ImagesRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // Dependency injection of ImagesRepositoryProtocol, default is ImagesRepository
    init(repository: ImagesRepositoryProtocol = ImagesRepository()) {
        self.repository = repository
    }
    
    // Fetch ImageData from the repository and handle the response
    func fetchImageData() {
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        let startDateString = startDate.dateString(withFormat: .yyyyMMdd)
        let endDateString = Date().dateString(withFormat: .yyyyMMdd)
        repository.getImagesData(startDate: startDateString, endDate: endDateString)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = "Failed to load posts: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] apods in
                DispatchQueue.main.async {
                    self?.apods = apods
                }
            })
            .store(in: &cancellables)
    }
}
