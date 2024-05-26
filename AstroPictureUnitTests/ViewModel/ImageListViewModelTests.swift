//
//  ImageListViewModelTests.swift
//  AstroPictureUnitTests
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import XCTest
import Combine
@testable import AstroPicture

class ImageListViewModelTests: XCTestCase {
    var viewModel: ImageListViewModel!
    var mockRepository: MockImagesRepository!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        mockRepository = MockImagesRepository()
        viewModel = ImageListViewModel(repository: mockRepository)
        cancellables = []
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
        cancellables = nil
        try? super.tearDownWithError()
    }

    func testFetchImageDataSuccess() {
        let expectedApods = [
            Apod(copyright: "Test Image",
                 date: "2024-05-26",
                 explanation: "A test image explanation",
                 hdurl: "https://test.com/image.jpg",
                 mediaType: "image",
                serviceVersion: "v1",
                 title: "Test Image",
                 url: "https://test.com/image.jpg"
                )
        ]
        mockRepository.result = .success(expectedApods)
        let expectation = self.expectation(description: "Images fetched successfully")
        viewModel.fetchImageData()
        viewModel.$apods
            .dropFirst()
            .sink { apods in
                XCTAssertEqual(apods.count, expectedApods.count)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
