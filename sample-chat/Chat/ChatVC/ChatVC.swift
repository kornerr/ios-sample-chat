
import RxCocoa
import RxSwift
import UIKit

class ChatVC : UIViewController, UITableViewDataSource {

    // MARK: - PUBLIC
    
    let messages: Variable<[String]> = Variable([])

    enum Const {
        static let ChatCell = "ChatCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChatVC()
    }

    // MARK: - PRIVATE

    private let disposeBag = DisposeBag()
    
    private func setupChatVC() {
        self.navigationItem.title = "Chat"

        self.setupTableView()

        // TODO: Reload table view when items change.
        self.messages
            .asObservable()
            .subscribe(onNext : { [unowned self] messages in
                NSLog("ChatVC. Messages now: '\(messages)'")
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    // MARK: - SEND VIEW

    override var canBecomeFirstResponder: Bool { return true; }

    var sendView: SendView!

    override var inputAccessoryView: UIView {
        get { return self.sendView }
    }

    // MARK: - TABLE VIEW

    @IBOutlet private var tableView: UITableView!

    private func setupTableView() {
        let cellNib = UINib(nibName: Const.ChatCell, bundle: nil)
        self.tableView.register(
            cellNib,
            forCellReuseIdentifier: Const.ChatCell)
        self.tableView.dataSource = self

        // Make sure cells are self-sizing.
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return self.messages.value.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: Const.ChatCell,
                for: indexPath)
            as! ChatCell
        cell.title = self.messages.value[indexPath.row]
        NSLog("Cell id: '\(indexPath.row)' title: '\(cell.title)'")
        return cell
    }
    
}

