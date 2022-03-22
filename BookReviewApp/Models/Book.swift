//
//  Book.swift
//  BookReviewApp
//
//  Created by 김정민 on 2022/03/21.
//

import Foundation

struct Book: Codable {
    let title: String
    private let image: String?
    
    var imageURL: URL? { URL(string: image ?? "")}
}
