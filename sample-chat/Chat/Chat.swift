
import RxSwift

import UIKit

class Chat {

    // MARK PUBLIC

    let messages: Variable<[String]> = Variable([])
    
    init() {
        self.messages.value = [
            "The first short line",
            "Extremely long second line that should span several rows or even more",
            "This one is short again. Or may be not. Span more to see if automatic dimension thing works fine"]
    }
}

