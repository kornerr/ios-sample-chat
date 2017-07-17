
import RxSwift

import UIKit

class Chats {

    // MARK PUBLIC

    let chats: Variable<[String]> = Variable([])
    
    init() {
        self.chats.value = [
            "The first short line",
            "Extremely long second line that should span several rows or even more",
            "This one is short again. Or may be not. Span more to see if automatic dimension thing works fine"]
    }
}

