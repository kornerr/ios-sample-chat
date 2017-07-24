
import SnapKit
import UIKit

public extension UIView {

    var embeddedView : UIView? {
        get {
            // We only work with single or no subview.
            if (self.subviews.count > 1) {
                return nil
            }
            return self.subviews.first
        }
        set {
            // We only work with single or no subview.
            if (self.subviews.count > 1) {
                return
            }
            if let subview = self.subviews.first {
                // Already embedded.
                if (newValue == subview) {
                    // Do nothing.
                    return
                }
                // Remove old subview.
                subview.removeFromSuperview()
            }
            if let view = newValue {
                // Add new subview.
                self.embedView(view)
            }
        }
    }

    private func embedView(_ other: UIView) {
        self.addSubview(other)
        other.snp.makeConstraints { [unowned self] (make) -> Void in
            make.edges.equalTo(self)
        }
    }

}

