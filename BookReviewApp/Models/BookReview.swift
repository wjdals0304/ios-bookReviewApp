//
//  BookReview.swift
//  BookReviewApp
//
//  Created by 김정민 on 2022/03/21.
//

import Foundation

struct BookReview: Codable {
    let title: String
    let contents: String
    let imageURL: URL?
}
