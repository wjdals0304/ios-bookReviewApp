//
//  MockReviewListViewController.swift
//  BookReviewAppTests
//
//  Created by 김정민 on 2022/03/22.
//

import Foundation


@testable import BookReviewApp

final class MockReviewListViewController: ReviewListProtocol {
    
    var isCalledSetupNavigationBar = false
    var isCalledSetupViews = false
    var isCalledPresentToReviewWriteViewController = false
    var isCalledReloadTableView = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
        
    }
    
    func setupViews() {
        isCalledSetupViews = true
    }
    
    func presentToReviewWriteViewController() {
        isCalledPresentToReviewWriteViewController = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
    

}
