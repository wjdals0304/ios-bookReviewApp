# BookReview 클론코딩 
- 30개프로젝트로배우는 iOS앱개발 with Swift초격차 패키지Online

<img src="https://user-images.githubusercontent.com/26668309/159628867-58be5eee-f790-40c2-a3b8-75dd2f3f669c.png" width = 20%> <img src="https://user-images.githubusercontent.com/26668309/159628970-f2157e84-141d-4914-b288-21c1174fce44.png" width = 30%> <img src="https://user-images.githubusercontent.com/26668309/159629291-bbd70366-c573-4b8f-a8d7-cd8e66b39363.png" width = 30%> 


# 사용요소 
-XCText, MVP, Snapkit, Alamofire 

# 새로 배운 내용 

- [MVP] ViewController 

```Swift 
final class ReviewListController: UIViewController {

    private lazy var presenter = ReviewListPresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

}
```

- [MVP] Presenter 

```Swift 
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
```
- XCTest 

```Swift 
import XCTest
@testable import BookReviewApp

class ReviewListPresenterTests: XCTestCase {
    
    var sut: ReviewListPresenter!
    var viewController: MockReviewListViewController!
    var userDefaultManager: MockUserDefaultManager!
    
    // 테스트할 때마다 실행되는 함수
    override func setUp() {
        super.setUp()
        viewController = MockReviewListViewController()
        userDefaultManager = MockUserDefaultManager()
        
        sut = ReviewListPresenter(viewController: viewController,
                                 userDefaultManager: userDefaultManager
        )
    }
    
    // 테스트 끝날때 실행되는 함수
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출될_때() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }
   
```

- Protocol Test 

```Swift 

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

```


