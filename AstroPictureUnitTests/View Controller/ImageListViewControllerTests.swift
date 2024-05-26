//
//  ImageListViewControllerTests.swift
//  AstroPictureUnitTests
//
//  Created by AMRUT WAGHMARE on 26/05/24.
//

import XCTest
@testable import AstroPicture
import Combine

final class ImageListViewControllerTests: XCTestCase {
    var viewController: ImageListViewController!
    var viewModel: ImageListViewModel!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "ImageListViewController") as? ImageListViewController
        viewModel = ImageListViewModel()
        viewController.testHooks.setViewModel(viewModel: viewModel)
        viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
        viewModel = nil
        try? super.tearDownWithError()
    }
    
    func testViewDidLoadCallsFetchImageData() {
        viewController.viewDidLoad()
        XCTAssertTrue(viewController.activityIndicator.isAnimating)
    }
    
    func testTableViewNumberOfRows() {
        viewController.testHooks.viewModel?.apods = [Apod(copyright: "Test Image",
                                     date: "2024-05-26",
                                     explanation: "A test image explanation",
                                     hdurl: "https://test.com/image.jpg",
                                     mediaType: "image",
                                    serviceVersion: "v1",
                                     title: "Test Image",
                                     url: "https://test.com/image.jpg"
                                    )]
        viewController.tableView.reloadData()
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func testTableViewCellForRow() {
        let apod = Apod(copyright: "Test Image",
                        date: "2024-05-26",
                        explanation: "A test image explanation",
                        hdurl: "https://test.com/image.jpg",
                        mediaType: "image",
                       serviceVersion: "v1",
                        title: "Test Image",
                        url: "https://test.com/image.jpg"
                       )
        viewController.testHooks.viewModel?.apods = [apod]
        viewController.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath) as! ImageListTableViewCell
        XCTAssertEqual(cell.titleLabel?.text, apod.title)
        XCTAssertEqual(cell.dateLabel?.text, apod.date)
    }
}
