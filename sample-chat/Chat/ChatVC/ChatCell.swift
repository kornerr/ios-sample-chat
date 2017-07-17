
import UIKit

class ChatCell: UITableViewCell {

    // MARK TITLE
    
    var title: String {
        get { return _title }
        set {
            _title = newValue
            self.updateTitle()
        }
    }
    private var _title: String = ""
    private func updateTitle() {
        self.titleLabel?.text = self.title
    }
    @IBOutlet private var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupChatsCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK PRIVATE

    private func setupChatsCell() {
        self.updateTitle()
    }

}

