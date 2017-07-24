
import RxSwift
import UIKit

class Chat {

    let messages: Variable<[ChatMessage]> = Variable([])
    
    init() {
        // Create stub messages.
        {
            var item = ChatMessage()
            item.author = "Bot"
            item.text = "The first short line"
            self.addMessage(item)
        }
        {
            var item = ChatMessage()
            item.author = "Bot"
            item.text = "Extremely long second line that should span several rows or even more"
            self.addMessage(item)
        }
        {
            var item = ChatMessage()
            item.author = "Bot"
            item.text = "This one is short again. Or may be not. Span more to see if automatic dimension thing works fine"
            self.addMessage(item)
        }
    }

    func addMessage(_ msg: ChatMessage) {
        self.messages.value.append(msg)
        NSLog("Chat. New message: '\(msg)'")
    }
}

