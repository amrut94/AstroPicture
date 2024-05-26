//
//  MockImagesRepository.swift
//  AstroPictureUnitTests
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import Combine
import Foundation
@testable import AstroPicture

class MockImagesRepository: ImagesRepositoryProtocol {
    var result: Result<[Apod], Error>?
    
    func getImagesData(startDate: String, endDate: String) -> AnyPublisher<[Apod], Error> {
        if let result = result {
            switch result {
            case .success(let data):
                return Just(data)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            case .failure(let error):
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
        } else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }
}
