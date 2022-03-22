//
//  MockUserDefaultsManager.swift
//  BookReviewAppTests
//
//  Created by 김정민 on 2022/03/22.
//

import Foundation

@testable import BookReviewApp

final class MockUserDefaultManager: UserDefaultManagerProtocol {
    
    var isCalledGetReviews = false
    var isCalledSetReview = false
    
    func getReviews() -> [BookReview] {
        isCalledGetReviews = true
        
        return []
    }
    
    func setReview(_ newValue: BookReview) {
        isCalledSetReview = true
        
    }
    
}
