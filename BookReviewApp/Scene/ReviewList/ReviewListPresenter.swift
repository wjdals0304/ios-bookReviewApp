//
//  ReviewListPresenter.swift
//  BookReviewApp
//
//  Created by 김정민 on 2022/03/20.
//

import UIKit
import Kingfisher

protocol ReviewListProtocol {
    
    func setupNavigationBar()
    func setupViews()
    func presentToReviewWriteViewController()
    func reloadTableView()
}

final class ReviewListPresenter: NSObject{
    private let viewController: ReviewListProtocol
    private let userDefaultManager: UserDefaultManagerProtocol
    
    private var review: [BookReview] = []
    
    
    init(viewController: ReviewListProtocol
         ,userDefaultManager : UserDefaultManagerProtocol = UserDefaultManager()
    ) {
        self.viewController = viewController
        self.userDefaultManager = userDefaultManager
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func viewWillAppear() {
        review = userDefaultManager.getReviews()
        viewController.reloadTableView()
    }
    
    func didTapRightBarButtonItem() {
        viewController.presentToReviewWriteViewController()
    }
    
}

extension ReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let review = review[indexPath.row]
        cell.textLabel?.text = review.title
        cell.detailTextLabel?.text = review.contents
    
        cell.imageView?.kf.setImage(with : review.imageURL, placeholder: .none) { _ in
            cell.setNeedsLayout()
        }
        cell.selectionStyle = .none
        return cell 
    }
    
    
}
