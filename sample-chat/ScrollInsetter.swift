
import UIKit

// Manage scroll view insets for when keyboard is shown or hidden.
class ScrollInsetter : NSObject {

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

    private var scrollView: UIScrollView!

    private func setupScrolling() {
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
    }

    private func tearDownScrolling() {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - SELECTORS
    
    func keyboardWillShow(notification: Notification) {
        let keyboardFrame =
            notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
        if let kbHeight = keyboardFrame?.cgRectValue.height {
            self.scrollView.contentInset =
                UIEdgeInsetsMake(0, 0, kbHeight, 0)
            self.scrollView.scrollIndicatorInsets =
                self.scrollView.contentInset
        }
    }

    func keyboardWillHide(notification: Notification) {
        UIView.animate(
            withDuration: Const.AnimDuration,
            animations: { [unowned self] _ in
                self.scrollView.contentInset =
                    UIEdgeInsetsMake(0, 0, 0, 0)
                self.scrollView.scrollIndicatorInsets =
                    self.scrollView.contentInset
        })
    }

}

