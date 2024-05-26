//
//  NetworkError.swift
//  AstroPicture
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed
    case decodingFailed(Error)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .requestFailed:
            return "The network request failed."
        case .decodingFailed(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
