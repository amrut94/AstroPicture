//
//  ImagesRepositoryTests.swift
//  AstroPictureUnitTests
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import XCTest
import Combine
@testable import AstroPicture

final class ImagesRepositoryTests: XCTestCase {
    var repository: ImagesRepository!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkService = MockNetworkService()
        repository = ImagesRepository(apiService: mockNetworkService)
        cancellables = []
    }

    override func tearDownWithError() throws {
        repository = nil
        mockNetworkService = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    func testGetImagesDataSuccess() {
        let expectedImages = [
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
        mockNetworkService.result = .success(expectedImages)
        let expectation = self.expectation(description: "Images fetched successfully")
        repository.getImagesData(startDate: "2024-05-20", endDate: "2024-05-26")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, got failure with error: \(error)")
                }
            }, receiveValue: { images in
                XCTAssertEqual(images.count, expectedImages.count)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetImagesDataFailure() {
        mockNetworkService.result = .failure(URLError(.badServerResponse))
        let expectation = self.expectation(description: "Failed to fetch images")
        repository.getImagesData(startDate: "2024-05-20", endDate: "2024-05-26")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure, got success")
                }
            }, receiveValue: { images in
                XCTFail("Expected no images, got \(images) instead")
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
