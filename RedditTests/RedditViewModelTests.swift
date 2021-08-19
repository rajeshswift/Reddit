//
//  RedditViewModelTests.swift
//  RedditTests
//
//  Created by Rajesh Bandarupalli on 08/18/21.
//

import XCTest
@testable import Reddit

class RedditViewModelTests: XCTestCase {
    
    var viewModel = RedditItemsViewModel()
    
    
    override func setUp() {
        super.setUp()
        viewModel.apiHelper = APIHelperMock.shared
        let jsonData = readJSON("RedditItems")
        let codableModel = try? JSONDecoder().decode(RedditModel.self, from: jsonData)
        if let model = codableModel {
            viewModel = RedditItemsViewModel(redditModel: model)
        }
    }
    func testViewModelFunctions() {
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel.afterIndex)
        XCTAssertGreaterThan(viewModel.childrenArr.count, 0)
        
    }
    func testAPIMethods() {
        viewModel.retriveItemsFromServer(after: "") {
            XCTAssertGreaterThan(self.viewModel.childrenArr.count, 0)
        }
    }

}
