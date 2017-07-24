
import RxCocoa
import RxSwift
import UIKit

class ChatVC : UIViewController {

    // MARK: - PUBLIC
    
    let messages: Variable<[ChatMessage]> = Variable([])

    enum Const {
        static let ChatView = "ChatView"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChatVC()
    }

    // MARK: - PRIVATE

    private let disposeBag = DisposeBag()
    
    private func setupChatVC() {
        self.setupChatView()
    }

    // MARK: - CHAT VIEW

    private var chatView: ChatView!
    @IBOutlet private var chatContainerView: UIView!

    private func setupChatView() {
        self.chatView = ChatView.loadFromNib()
        self.chatContainerView.embeddedView = self.chatView

        // Sync items.
        self.messages
            .asObservable()
            .bind(to: self.chatView.messages)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: - SEND VIEW

    override var canBecomeFirstResponder: Bool { return true; }

    var sendView: SendView!

    override var inputAccessoryView: UIView {
        get { return self.sendView }
    }

}

