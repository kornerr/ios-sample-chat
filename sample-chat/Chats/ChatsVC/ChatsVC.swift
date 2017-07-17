
import RxCocoa
import RxSwift
import UIKit

class ChatsVC : UIViewController, UITableViewDataSource {
    
    enum Const {
        static let ChatsCell = "ChatsCell"
    }

    // MARK PUBLIC

    let chats: Variable<[String]> = Variable([])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK PRIVATE

    @IBOutlet var tableView: UITableView!

    private let disposeBag = DisposeBag()
    
    private func setup() {
        self.navigationItem.title = "Chats"

        self.setupChats()
    }

    private func setupChats() {
        self.setupTableView()

        // TODO: Reload table view when items change.
        self.chats
            .asObservable()
            .subscribe(onNext : { [unowned self] chats in
                NSLog("ChatsVC. Items now: '\(chats)'")
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func setupTableView() {
        let cellNib = UINib(nibName: Const.ChatsCell, bundle: nil)
        self.tableView.register(
            cellNib,
            forCellReuseIdentifier: Const.ChatsCell)
        self.tableView.dataSource = self

        // Make sure cells are self-sizing.
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
    }

    // MARK DELEGATE

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return self.chats.value.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        NSLog("ChatsVC. cellForRow: '\(indexPath.row)'")

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: Const.ChatsCell,
                for: indexPath)
            as! ChatsCell
        cell.title = self.chats.value[indexPath.row]
        NSLog("Cell id: '\(indexPath.row)' title: '\(cell.title)'")
        return cell
    }
    
}

