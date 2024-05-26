//
//  NetworkService.swift
//  AstroPicture
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkService {
    func performRequest<T>(from request: URLRequest) -> AnyPublisher<T, any Error> where T : Decodable {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.requestFailed
                }
                return output.data
            }
            .mapError { error in
                return NetworkError.unknown(error)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return NetworkError.decodingFailed(decodingError)
                }
                return NetworkError.unknown(error)
            }
            .eraseToAnyPublisher()
    }
    
    /// Constructs a URLRequest based on the provided URL, HTTP method, and optional parameters.
    /// - Parameters:
    ///   - url: The URL for the request.
    ///   - method: The HTTP method for the request.
    ///   - params: Optional dictionary containing parameters for the request.
    /// - Returns: A URLRequest object configured based on the provided parameters.
    private func generateUrlRequest(url: URL, method: HTTPMethod, params: [String : String]?) -> URLRequest {
        var request: URLRequest
        
        switch method {
        case .get:
            // Construct URL with query parameters for GET request
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            if let params = params {
                urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
            }
            guard let finalURL = urlComponents.url else {
                fatalError("Failed to construct URL")
            }
            request = URLRequest(url: finalURL)
            
        case .post:
            // Construct URL request with HTTP body for POST request
            request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            if let params = params {
                request.httpBody = try? JSONSerialization.data(withJSONObject: params)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        return request
    }
}


// Implementation of the NetworkServiceProtocol
extension NetworkService: NetworkServiceProtocol {
    
    /// Fetche data from a specified URL with a given HTTP method and optional parameters.
    /// - Parameters:
    ///   - url: The URL for the request.
    ///   - method: The HTTP method for the request.
    ///   - params: Optional dictionary containing parameters for the request.
    /// - Returns: A publisher emitting a decoded result of type T or an error, conforming to the Decodable protocol
    func fetchImagesData<T>(from url: String, method: HTTPMethod, params: [String : String]?) -> AnyPublisher<T, any Error> where T : Decodable {
        
        guard let url = URL(string: url) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        let request: URLRequest = generateUrlRequest(url: url, method: method, params: params)
        return performRequest(from: request)
    }
}
