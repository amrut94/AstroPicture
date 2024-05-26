//
//  ImagesRepository.swift
//  AstroPicture
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import Combine
import Foundation

// Protocol defining the contract for the Images Repository
protocol ImagesRepositoryProtocol {
    // Function to get posts, returns a publisher emitting an array of Post objects or an error
    func getImagesData(startDate: String, endDate: String) -> AnyPublisher<[Apod], Error>
}

// Implementation of the ImagesRepositoryProtocol
class ImagesRepository: ImagesRepositoryProtocol {
    private let apiService: NetworkServiceProtocol
    
    // Dependency injection of NetworkServiceProtocol, default is NetworkService
    init(apiService: NetworkServiceProtocol = NetworkService()) {
        self.apiService = apiService
    }
    
    /// Fetch Images from the API using the injected API service
    /// - Parameters:
    ///   - startDate: start date image
    ///   - endDate: end date of image
    /// - Returns: Image date
    func getImagesData(startDate: String, endDate: String) -> AnyPublisher<[Apod], any Error> {
        return apiService.fetchImagesData(
            from: NetworkConstant.baseURL,
            method: .get,
            params:["api_key": NetworkConstant.apikey,
                    "start_date": startDate,
                    "end_date": endDate]
        )
    }
}
