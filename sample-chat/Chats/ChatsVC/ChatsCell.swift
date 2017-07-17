
import UIKit

class ChatsCell: UITableViewCell {

    // MARK PUBLIC
    
    private var _title: String = ""
    var title: String {
        get { return _title }
        set {
            _title = newValue
            self.updateTitle()
        }
    }

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

    // MARK TITLE

    @IBOutlet private var titleLabel: UILabel!

    private func updateTitle() {
        self.titleLabel?.text = self.title
    }

}

