
import RxSwift
import UIKit

class ChatView: UIView, UITableViewDataSource {

    // MARK: - PUBLIC

    let messages: Variable<[ChatMessage]> = Variable([])

    enum Const {
        static let ChatItemCell = "ChatItemCell"
        static let ChatItemCellEstimatedHeight : CGFloat = 60
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupChatView()
    }

    // MARK: - PRIVATE

    private let disposeBag = DisposeBag()

    @IBOutlet private var tableView: UITableView!
    
    private func scrollToBottom() {
        if (self.messages.value.count > 0) {
            let lastRow =
                IndexPath(
                    row: self.messages.value.count - 1,
                    section: 0)
            self.tableView.scrollToRow(
                at: lastRow,
                at: .bottom,
                animated: true)
        }
    }

    private func setupChatView() {
        self.setupTableView()

        // Refresh table view when items change.
        self.messages
            .asObservable()
            .subscribe(onNext: { [unowned self] _ in
                self.tableView.reloadData()
                /*
                let lastRow =
                    IndexPath(
                        row: self.notifications.value.count - 1,
                        section: 0)
                NSLog("latRow: '\(lastRow.row)'")
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [lastRow], with: .none)
                self.tableView.endUpdates()
                */
                self.scrollToBottom()
            })
            .disposed(by: self.disposeBag)
    }

    private func setupTableView() {
        // Register cells.
        let cellNib = UINib(nibName: Const.ChatItemCell, bundle: nil)
        self.tableView.register(
            cellNib,
            forCellReuseIdentifier: Const.ChatItemCell)

        self.tableView.dataSource = self
        
        // Make sure cells are self-sizing.
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight =
            Const.ChatItemCellEstimatedHeight
    }

    // MARK: - TABLE VIEW DELEGATE

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {

        return self.messages.value.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        NSLog("cellForRow(\(indexPath.row))")

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: Const.ChatItemCell,
                for: indexPath)
            as! ChatItemCell
        let item = self.messages.value[indexPath.row]
        cell.date = item.date
        cell.contents = item.text
        return cell
    }

}

