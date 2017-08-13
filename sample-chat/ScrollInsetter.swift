
import RxSwift
import UIKit

// Manage scroll view insets for when keyboard is shown or hidden.
class ScrollInsetter : NSObject {

    // MARK: - PUBLIC

    init(scrollView: UIScrollView) {
        super.init()
        self.scrollView = scrollView
        self.setupScrollInsetter()
    }

    // MARK: - PRIVATE

    private enum Const {
        static let AnimDuration = 0.2
    }

    private weak var scrollView: UIScrollView?
    private var keyboard: Keyboard!
    private let disposeBag = DisposeBag()

    private func setupScrollInsetter() {
        self.keyboard = Keyboard()

        // Change insets based on keyboard height.
        self.keyboard.height
            .asObservable()
            .subscribe(onNext: { [unowned self] height in
                NSLog("Change insets, kb height: '\(height)'")
                let insets = UIEdgeInsetsMake(0, 0, CGFloat(height), 0)
                self.scrollView?.contentInset = insets
                self.scrollView?.scrollIndicatorInsets = insets
            })
            .disposed(by: self.disposeBag)
    }

}

