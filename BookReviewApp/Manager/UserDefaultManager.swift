//
//  UserDefaultManager.swift
//  BookReviewApp
//
//  Created by 김정민 on 2022/03/21.
//

import Foundation

protocol UserDefaultManagerProtocol {
    func getReviews() -> [BookReview]
    func setReview(_ newValue: BookReview)
}

struct UserDefaultManager : UserDefaultManagerProtocol {
    enum Key:String {
        case review
    }
    
    func getReviews() -> [BookReview] {
        guard let data = UserDefaults.standard.data(forKey: Key.review.rawValue) else { return [] }
        
        return ( try? PropertyListDecoder().decode([BookReview].self, from: data)) ?? [] 
    }
    
    func setReview(_ newValue: BookReview) {
        
        var currentReviews: [BookReview] = getReviews()
        currentReviews.insert(newValue, at: 0)
        
        UserDefaults.standard.setValue(try? PropertyListEncoder().encode(currentReviews), forKey: Key.review.rawValue)
        
    }
    
}
