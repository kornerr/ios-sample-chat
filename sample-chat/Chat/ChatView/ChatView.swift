
import RxSwift
import UIKit

class ChatView: UIView, UITableViewDataSource, UITableViewDelegate {

    // MARK: - PUBLIC

    let messages: Variable<[ChatMessage]> = Variable([])

    enum Const {
        static let ChatItemCell = "ChatItemCell"
        static let ChatItemCellEstimatedHeight : CGFloat = 100
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupChatView()
    }

    // MARK: - PRIVATE

    private let disposeBag = DisposeBag()

    private func setupChatView() {
        self.setupTableView()

        // Insert new items into table view.
        self.messages
            .asObservable()
            .filter { return !$0.isEmpty }
            .subscribe(onNext: { [unowned self] _ in
                let lastRow =
                    IndexPath(
                        row: self.messages.value.count - 1,
                        section: 0)
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [lastRow], with: .none)
                self.tableView.endUpdates()

                self.scrollToBottom()
            })
            .disposed(by: self.disposeBag)
    }

    // MARK: - TABLE VIEW

    @IBOutlet private var tableView: UITableView!
    private var scrollInsetter: ScrollInsetter!
    
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

    private func setupTableView() {
        // Register cells.
        let cellNib = UINib(nibName: Const.ChatItemCell, bundle: nil)
        self.tableView.register(
            cellNib,
            forCellReuseIdentifier: Const.ChatItemCell)

        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.setupTableViewCellHeight()
        self.setupTableViewScrolling()
    }

    private var keyboard: Keyboard!

    private func setupTableViewScrolling() {
        self.scrollInsetter = ScrollInsetter(scrollView: self.tableView)
        self.keyboard = Keyboard()

        // Scroll to bottom upon showing/hiding keyboard.
        self.keyboard.state
            .asObservable()
            .subscribe(onNext: { [unowned self] _ in
                NSLog("Scroll to bottom, because keyboard state changed")
                self.scrollToBottom()
            })
            .disposed(by: self.disposeBag)
    }

    // MARK: - TABLE VIEW CELL HEIGHT
    // Cell height caching: https://stackoverflow.com/a/33397350/3404710
    
    private var cachedCellHeights = [IndexPath : CGFloat]()

    func setupTableViewCellHeight() {
        // Make cells self-sizing.
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        // Retrieve cell height if it has been visible at least once.
        if let height = self.cachedCellHeights[indexPath] {
            return height
        }
        // The first display uses automatic calculation.
        else {
            return UITableViewAutomaticDimension
        }
    }

    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath) {

        // Cache cell height.
        self.cachedCellHeights[indexPath] = cell.frame.size.height
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
        cell.author = item.author
        cell.date = item.date
        cell.contents = item.text
        return cell
    }

}

