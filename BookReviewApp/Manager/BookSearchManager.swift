//
//  BookSearchManager.swift
//  BookReviewApp
//
//  Created by 김정민 on 2022/03/21.
//

import Foundation
import Alamofire

struct BookSearchManager {
    
    func request(from keyword: String, completionHandler: @escaping (([Book]) -> Void)) {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/book.json") else { return }

        let parameters = BookSearchRequestModel(query: keyword)
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "Paz9_qojs7Zfv5rc4VGa",
            "X-Naver-Client-Secret": "_NniQaC1Gh"
        ]

        AF
            .request(url, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: BookSearchResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
 
}
