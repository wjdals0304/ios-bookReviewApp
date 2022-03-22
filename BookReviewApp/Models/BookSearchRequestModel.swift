//
//  BookSearchRequestModel.swift
//  BookReviewApp
//
//  Created by 김정민 on 2022/03/21.
//

import Foundation


struct BookSearchRequestModel: Codable {
    /// 검색할 책 키워드
    let query: String
    
}
