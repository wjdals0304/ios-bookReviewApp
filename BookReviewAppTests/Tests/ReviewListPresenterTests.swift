//
//  ReviewListPresenterTests.swift
//  ReviewListPresenterTests
//
//  Created by 김정민 on 2022/03/20.
//

import XCTest
@testable import BookReviewApp

class ReviewListPresenterTests: XCTestCase {
    
    var sut: ReviewListPresenter!
    var viewController: MockReviewListViewController!
    var userDefaultManager: MockUserDefaultManager!
    
    
    override func setUp() {
        super.setUp()
        viewController = MockReviewListViewController()
        userDefaultManager = MockUserDefaultManager()
        
        sut = ReviewListPresenter(viewController: viewController,
                                 userDefaultManager: userDefaultManager
        )
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될_때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
    
    func test_viewWillAppear가_호출될_때() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefaultManager.isCalledGetReviews)
        XCTAssertTrue(viewController.isCalledReloadTableView)
    }
    
    
    func test_didTapRightBarButtonItem이_호출될_때() {
        sut.didTapRightBarButtonItem()
        
        XCTAssertTrue(viewController.isCalledPresentToReviewWriteViewController)
    }
    
    
}


