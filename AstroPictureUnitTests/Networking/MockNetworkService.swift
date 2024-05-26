//
//  MockNetworkService.swift
//  AstroPictureUnitTests
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import Combine
import Foundation
@testable import AstroPicture

class MockNetworkService: NetworkServiceProtocol {
    var result: Result<[Apod], Error>?

    func fetchImagesData<T>(from url: String, method: AstroPicture.HTTPMethod, params: [String : String]?) -> AnyPublisher<T, any Error> where T : Decodable {
        if let result = result as? Result<T, Error> {
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
