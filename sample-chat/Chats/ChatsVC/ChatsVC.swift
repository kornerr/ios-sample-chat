
import SnapKit
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

    @IBOutlet private var topView: UIView!
    @IBOutlet private var deviceTokenLabel: UILabel!
    @IBOutlet private var deviceTokenTextView: UITextView!
    @IBOutlet private var notificationsLabel: UILabel!

    private let disposeBag = DisposeBag()
    
    private func setup() {
        self.navigationItem.title = "Chats"

        self.setupTopOffset()
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

    private func setupTopOffset() {
        // Make sure topView's top is anchored to topLayoutGuide's bottom.
        self.topView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
    }
    
}

