//
//  Apod.swift
//  AstroPicture
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import Foundation

struct Apod: Codable {
    let copyright: String?
    let date: String?
    let explanation: String?
    let hdurl: String?
    let mediaType: String?
    let serviceVersion: String?
    let title: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
    }
}
