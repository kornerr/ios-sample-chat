
import RxCocoa
import RxSwift
import UIKit

class SendView: UIView {

    // MARK: - PUBLIC

    let lastMessage: Variable<String> = Variable("")

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupSendView()
    }

    // MARK: - PRIVATE
    
    private let disposeBag: DisposeBag = DisposeBag()

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var sendButton: UIButton!

    private func setupSendView() {
        NSLog("SendView.setup")

        // Report latest message.
        self.sendButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            if (self.textField != nil) {
              self.lastMessage.value = self.textField!.text!
            }
        })
        .disposed(by: disposeBag)

        // Erase text field.
        self.sendButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.textField?.text = ""
        })
        .disposed(by: disposeBag)
    }

}

