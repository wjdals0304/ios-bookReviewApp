//
//  ReviewWritePresenter.swift
//  BookReviewApp
//
//  Created by 김정민 on 2022/03/20.
//

import Foundation

protocol ReviewWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertController()
    func close()
    func setupViews()
    func presentToSearchBookViewController()
    func updateViews(title: String, imageURL: URL?)
}

final class ReviewWritePresenter{
    private let viewController: ReviewWriteProtocol
    private let userDefaultManager = UserDefaultManager()

    private var book: Book?
    let contentsTextViewPlaceHolderText = "내용을 입력해주세요"
    
    init(viewController: ReviewWriteProtocol) {
        self.viewController = viewController
    }
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func didTapLeftBarButton() {
        viewController.showCloseAlertController()
    }
    
    func didTapRightBarButton(contentsText: String?) {
        
        guard let book = book , let contentsText = contentsText,
        contentsText != contentsTextViewPlaceHolderText 
        else { return }
        
        let bookReview = BookReview(title: book.title, contents: contentsText, imageURL: book.imageURL)
        userDefaultManager.setReview(bookReview)
        viewController.close()
    }
    
    func didTapBookTitleButton() {
        viewController.presentToSearchBookViewController()
    }
    
}

extension ReviewWritePresenter : SearchBookDelegate {
    func selectBook(_ book: Book) {
        self.book = book
        viewController.updateViews(title: book.title, imageURL: book.imageURL)
    }
}
