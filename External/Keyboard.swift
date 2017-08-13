
import RxSwift
import UIKit

// Keyboard state and height.
class Keyboard : NSObject {

    // MARK: - STATE
    
    enum State {
        case None
        case Shown
        case Hidden
    }

    let state: Variable<State> = Variable(.None)

    // MARK: - HEIGHT

    let height: Variable<Float> = Variable(0.0)

    // MARK: - PUBLIC

    override init() {
        super.init()
        // Track height.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(Keyboard.keyboardWillShow(notification:)),
            name: .UIKeyboardWillShow,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(Keyboard.keyboardWillHide(notification:)),
            name: .UIKeyboardWillHide,
            object: nil)

        // Track state.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(Keyboard.keyboardDidShow(notification:)),
            name: .UIKeyboardDidShow,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(Keyboard.keyboardDidHide(notification:)),
            name: .UIKeyboardDidHide,
            object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - STATE

    func keyboardDidHide(notification: Notification) {
        self.state.value = .Hidden
    }

    func keyboardDidShow(notification: Notification) {
        self.state.value = .Shown
    }

    // MARK: - HEIGHT
    
    func keyboardWillHide(notification: Notification) {
        self.height.value = 0
    }

    func keyboardWillShow(notification: Notification) {
        let keyboardFrame =
            notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
        if let kbHeight = keyboardFrame?.cgRectValue.height {
            self.height.value = Float(kbHeight)
        }
        else {
            let invalidHeight : Float = 10.0
            self.height.value = invalidHeight
        }
    }

}

