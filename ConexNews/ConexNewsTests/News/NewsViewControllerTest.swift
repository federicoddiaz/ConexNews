//
//  NewsViewControllerTest.swift
//  ConexNewsTests
//
//  Created by Federico Díaz on 21/05/2024.
//

import XCTest
@testable import ConexNews

final class NewsViewControllerTest: XCTestCase {

    var viewController: NewsViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = NewsViewController()
        viewController.setViewModel(newsRepository: NewsMockRepository())
        viewController.loadViewIfNeeded()
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewController.tableView.dataSource, "Table must contain data source")
        XCTAssertTrue(viewController.tableView.dataSource is NewsViewController)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewController.tableView.delegate, "Table must contain delegate")
        XCTAssertTrue(viewController.tableView.delegate is NewsViewController)
    }
    
    func testTableViewNumberOfRowsInSection() {
        let numberOfRows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, viewController.viewModel.numberOfNews(), "Number of rows must be equals to number of news")
    }
    
    func testSearchResults() {
        viewController.viewModel.delegate = viewController
        viewController.searchBar(viewController.searchBar, textDidChange: "Dolor")
        
        let searchExpectation = XCTestExpectation(description: "Search results updated")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            searchExpectation.fulfill()
        }
        wait(for: [searchExpectation], timeout: 5.0)
        
        XCTAssertEqual(viewController.viewModel.numberOfFilteredNews(), 1)
        XCTAssertEqual(viewController.viewModel.getFilteredPost(at: 0)?.title, "Dolor Sit Amet")
    }
}
