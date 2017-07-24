
import UIKit

class ChatItemCell: UITableViewCell {

    // MARK: - OVERRIDE

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupNotificationsItemCell()
    }

    // MARK: - PROPERTY DATE
    
    var date: Date {
        get { return _date }
        set {
            _date = newValue
            self.updateDate()
        }
    }

    private var _date = Date()

    @IBOutlet private var dateLabel: UILabel!

    private func updateDate() {
        // Format date.
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        self.dateLabel?.text = dateFormatter.string(from: self.date)
    }

    // MARK: - PROPERTY CONTENTS
    
    var contents: String {
        get { return _contents }
        set {
            _contents = newValue
            self.updateContents()
        }
    }

    private var _contents = ""

    @IBOutlet private var contentsLabel: UILabel!

    private func updateContents() {
        self.contentsLabel?.text = self.contents
    }

    // MARK: - THEME
    
    @IBOutlet private var shadowedView: UIView!
    @IBOutlet private var roundedView: UIView!

    private func setupTheme() {
        // Round corners.
        self.roundedView.layer.borderWidth = 0
        self.roundedView.layer.cornerRadius = 5
        self.roundedView.clipsToBounds = true
        // Shadow.
        self.shadowedView.layer.shadowColor = UIColor.black.cgColor
        self.shadowedView.layer.shadowRadius = 4
        self.shadowedView.layer.shadowOffset = CGSize(width: 0, height:3)
        self.shadowedView.layer.shadowOpacity = 0.2
    }

    // MARK: - PRIVATE

    private func setupNotificationsItemCell() {
        self.setupTheme()
        self.updateDate()
    }

}

