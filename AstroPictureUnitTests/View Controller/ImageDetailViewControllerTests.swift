//
//  ImageDetailViewControllerTests.swift
//  AstroPictureUnitTests
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import XCTest
@testable import AstroPicture
import Combine

final class ImageDetailViewControllerTests: XCTestCase {
    var viewController: ImageDetailViewController!
    var viewModel: ImageDetailViewModel!
    let apod = Apod(copyright: "Test Image",
                    date: "2024-05-26",
                    explanation: "A test image explanation",
                    hdurl: "https://test.com/image.jpg",
                    mediaType: "image",
                   serviceVersion: "v1",
                    title: "Test Image",
                    url: "https://test.com/image.jpg"
                   )

    override func setUpWithError() throws {
        try? super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: ImageDetailViewController.identfire) as? ImageDetailViewController
        viewModel = ImageDetailViewModel(apod: apod)
        viewController.viewModel = viewModel
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
        viewModel = nil
        try? super.tearDownWithError()
    }

    func testViewDidLoad() {
        viewController.viewDidLoad()
        XCTAssertEqual(viewController.titleLabel.text, apod.title)
        XCTAssertEqual(viewController.dateLabel.text, apod.date)
        XCTAssertEqual(viewController.descriptionLabel.text, apod.explanation)
    }
}
