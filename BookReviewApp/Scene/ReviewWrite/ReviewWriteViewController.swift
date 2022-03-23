//
//  ReviewWriteViewController.swift
//  BookReviewApp
//
//  Created by 김정민 on 2022/03/20.
//

import UIKit
import SnapKit
import Kingfisher

final class ReviewWriteViewController : UIViewController {
    private lazy var presenter = ReviewWritePresenter(viewController: self)
    
    private lazy var bookTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("책 제목", for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 23.0,weight: .bold)
        button.addTarget(self, action: #selector(didTapBookTitleButton), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var contentsTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .tertiaryLabel
        textView.text = presenter.contentsTextViewPlaceHolderText
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        textView.delegate = self
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension ReviewWriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else {
            return
        }
        
        textView.text = nil
        textView.textColor = .label
    }
}

extension ReviewWriteViewController: ReviewWriteProtocol {
    
    func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapLeftBarButton))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapRightBarButton))
    }
    
    func showCloseAlertController() {
        let alertController = UIAlertController(title: "작성중인 내용이 있습니다. 정말 닫으시껬습니다?", message: nil, preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "닫기", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel )
        
        [closeAction,cancelAction].forEach {
            alertController.addAction($0)
        }
        
        present(alertController, animated: true)
    }
    
    func close() {
        dismiss(animated: true)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        [bookTitleButton, contentsTextView, imageView].forEach{ view.addSubview($0) }
        bookTitleButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        contentsTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(bookTitleButton.snp.bottom).offset(16.0)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(contentsTextView.snp.leading)
            make.trailing.equalTo(contentsTextView.snp.trailing)
            make.top.equalTo(contentsTextView.snp.bottom).offset(16)
            
            make.height.equalTo(200)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func presentToSearchBookViewController() {
        let vc = UINavigationController(rootViewController: SearchBookViewController(searchBookDelegate: presenter))
        present(vc, animated: true)
    }
    
    func updateViews(title: String, imageURL: URL?) {
        bookTitleButton.setTitle(title, for: .normal)
        bookTitleButton.setTitleColor(.label, for: .normal)
        imageView.kf.setImage(with: imageURL)
    }
    
}


private extension ReviewWriteViewController {
    @objc func didTapLeftBarButton() {
        presenter.didTapLeftBarButton()
    }
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton(contentsText: contentsTextView.text)
    }
    
    @objc func didTapBookTitleButton() {
        presenter.didTapBookTitleButton()
    }

}
