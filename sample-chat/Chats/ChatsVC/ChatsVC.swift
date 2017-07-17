
import RxCocoa
import RxSwift
import UIKit

class ChatsVC : UIViewController, UITableViewDataSource {

    // MARK: PUBLIC

    let chats: Variable<[String]> = Variable([])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: PRIVATE

    @IBOutlet var tableView: UITableView!

    private let disposeBag = DisposeBag()
    
    private func setup() {
        self.navigationItem.title = "Chats"

        self.setupChats()
    }

    private func setupChats() {
        /*
        self.deviceToken
            .asObservable()
            .bind(to: self.deviceTokenTextView.rx.text)
            .disposed(by: disposeBag)
        */
        let cellNib = UINib(nibName: "ChatsCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "ChatsCell")
        
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        NSLog("ChatsVC. Number of rows")
        return 3;
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        NSLog("ChatsVC. cellForRow: '\(indexPath.row)'")

        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "ChatsCell",
                for: indexPath)
        NSLog("Cell: '\(cell)'")
        return cell
    }
    
}

