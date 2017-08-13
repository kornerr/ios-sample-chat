
import RxSwift
import UIKit

// Manage scroll view insets for when keyboard is shown or hidden.
class ScrollInsetter : NSObject {

    // MARK: - SIGNALS
    
    enum Signal {
        case None
        case KeyboardShown
        case KeyboardHidden
    }

    let signal: Variable<Signal> = Variable(.None)

    // MARK: - PUBLIC

    init(scrollView: UIScrollView) {
        super.init()
        self.scrollView = scrollView
        self.setupScrolling()
    }

    deinit {
        self.tearDownScrolling()
    }

    // MARK: - PRIVATE

    private enum Const {
        static let AnimDuration = 0.2
    }

    private weak var scrollView: UIScrollView?

    private func setupScrolling() {
        /*
        // Control insets.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ScrollInsetter.keyboardWillShow(notification:)),
            name: .UIKeyboardWillShow,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ScrollInsetter.keyboardWillHide(notification:)),
            name: .UIKeyboardWillHide,
            object: nil)
        // Report keyboard state.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ScrollInsetter.keyboardDidShow(notification:)),
            name: .UIKeyboardDidShow,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ScrollInsetter.keyboardDidHide(notification:)),
            name: .UIKeyboardDidHide,
            object: nil)
            */
    }

    private func tearDownScrolling() {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - REPORTING

    func keyboardDidHide(notification: Notification) {
        self.signal.value = .KeyboardHidden
    }

    func keyboardDidShow(notification: Notification) {
        self.signal.value = .KeyboardShown
    }

    // MARK: - INSETS
    
    func keyboardWillHide(notification: Notification) {
        UIView.animate(
            withDuration: Const.AnimDuration,
            animations: { [unowned self] in
                if let scrollView = self.scrollView {
                    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
                    scrollView.scrollIndicatorInsets = scrollView.contentInset
                }
        })
    }

    func keyboardWillShow(notification: Notification) {
        let keyboardFrame =
            notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
        if let kbHeight = keyboardFrame?.cgRectValue.height, let scrollView = self.scrollView {
            
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, kbHeight, 0)
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        }
    }

}

