
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
        let cellNib = UINib(nibName: Const.ChatsCell, bundle: nil)
        self.tableView.register(
            cellNib,
            forCellReuseIdentifier: Const.ChatsCell)
        self.tableView.dataSource = self

        // TODO: Reload table view when items change.
        self.chats
            .asObservable()
            .subscribe(onNext : { chats in
                NSLog("Chats changed to '\(chats)'")
                //self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

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

