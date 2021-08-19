//
//  RedditVCTests.swift
//  RedditTests
//
//  Created by Rajesh Bandarupalli on 08/18/21.
//

import UIKit
import XCTest
@testable import Reddit

class RedditVCTests: XCTestCase {
    
    var subject:RedditItemsVC!
    var viewModel = RedditItemsViewModel()
    override func setUp() {
        
        viewModel.apiHelper = APIHelperMock.shared
        let jsonData = readJSON("RedditItems")
        let codableModel = try? JSONDecoder().decode(RedditModel.self, from: jsonData)
        if let model = codableModel {
            viewModel = RedditItemsViewModel(redditModel: model)
            subject = RedditItemsVC(vm: viewModel)
        }
        subject.viewDidLoad()
        subject.loadView()
        
    }
    
    
    func testViewController(){
        XCTAssertNotNil(subject)
        XCTAssertNotNil(subject.view)
        XCTAssertEqual(subject.title, "Reddit Items")
        
    }
    
    func testRedditViewProperties()
    {
        subject.redditView.layoutSubviews()
        XCTAssertNotNil(subject.redditView.layoutSubviews())
        XCTAssertNotNil(subject.redditView)
        XCTAssertNotNil(subject.redditView.viewModel)
        XCTAssertEqual(subject.redditView.isServiceCallinProgress, false)
        XCTAssertNotNil(subject.redditView.configureView())
        
        
        let numberOfRwos = subject.redditView.tableView(subject.redditView.tableview, numberOfRowsInSection: 0)
        XCTAssertEqual(subject.viewModel?.childrenArr.count, numberOfRwos)

        let cell:ItemsTableViewCell = subject.redditView.tableView(subject.redditView.tableview, cellForRowAt: IndexPath(row: 0, section: 0)) as! ItemsTableViewCell
        XCTAssertNotNil(cell)
        let firstItem = viewModel.childrenArr[0]
        cell.configureCell(child: firstItem)
        XCTAssertNotNil(cell.itemTitle)
        XCTAssertEqual(cell.itemTitle.text, firstItem.data?.title)
        XCTAssertNotNil(cell.itemImageView)
    }

}
