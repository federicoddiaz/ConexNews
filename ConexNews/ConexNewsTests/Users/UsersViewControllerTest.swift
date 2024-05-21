//
//  UsersViewControllerTest.swift
//  ConexNewsTests
//
//  Created by Federico Díaz on 21/05/2024.
//

import XCTest
@testable import ConexNews

final class UsersViewControllerTest: XCTestCase {
    var viewController: UsersViewController!
    
    override func setUp() {
        super.setUp()
        viewController = UsersViewController()
        viewController.setViewModel(usersRepository: UsersMockRepository())
        viewController.loadViewIfNeeded()
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewController.tableView.dataSource, "Table must contain data source")
        XCTAssertTrue(viewController.tableView.dataSource is UsersViewController)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewController.tableView.delegate, "Table must contain delegate")
        XCTAssertTrue(viewController.tableView.delegate is UsersViewController)
    }
    
    func testTableViewNumberOfRowsInSection() {
        let numberOfRows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, viewController.viewModel.numberOfUsers(), "Number of rows must be equals to number of users")
    }

}
