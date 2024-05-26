//
//  NetworkServiceProtocol.swift
//  AstroPicture
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import Foundation
import Combine

// Protocol defining the contract for the API Service
protocol NetworkServiceProtocol {
    // Generic function to fetch data from a given URL, returns a publisher
    func fetchImagesData<T: Decodable>(from url: String, method: HTTPMethod, params: [String: String]?) -> AnyPublisher<T, Error>
}
