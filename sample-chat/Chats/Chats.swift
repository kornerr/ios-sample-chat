
import RxSwift

import UIKit

class Chats {

    // MARK PUBLIC

    let chats: Variable<[String]> = Variable([String]())
    
    init() {
        self.chats.value = ["abc", "def", "ghi"]
    }
}

