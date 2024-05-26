//
//  ImageDetailViewModel.swift
//  AstroPicture
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import Foundation
import Combine

class ImageDetailViewModel: ObservableObject {
    let apod: Apod

    init(apod: Apod) {
        self.apod = apod
    }
}
