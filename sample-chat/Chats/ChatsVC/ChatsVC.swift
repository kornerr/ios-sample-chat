
import RxCocoa
import RxSwift
import UIKit

class ChatsVC : UIViewController {

    // MARK: PUBLIC

    let chats: Variable<[String]> = Variable([String]())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: PRIVATE

    @IBOutlet var tableView: UITableView!

    private let disposeBag = DisposeBag()
    
    private func setup() {
        self.navigationItem.title = "Chats"

        self.setupChats()
    }

    private func setupChats() {
        /*
        self.deviceToken
            .asObservable()
            .bind(to: self.deviceTokenTextView.rx.text)
            .disposed(by: disposeBag)
        */
    }

    
}

