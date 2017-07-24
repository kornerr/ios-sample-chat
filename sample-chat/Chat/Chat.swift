
import RxSwift
import UIKit

class Chat {

    // MARK: - PUBLIC

    let messages: Variable<[ChatMessage]> = Variable([])
    
    init() {
        self.setupStubItems()
    }

    func addMessage(_ msg: ChatMessage) {
        self.messages.value.append(msg)
        NSLog("Chat. New message: '\(msg)'")
    }

    // MARK: - PRIVATE
    private func setupStubItems() {
        // 1.
        var item = ChatMessage()
        item.author = "Bot"
        item.text = "The first short line"
        self.addMessage(item)
        // 2.
        item = ChatMessage()
        item.author = "Bot"
        item.text = "Extremely long second line that should span several rows or even more"
        self.addMessage(item)
        // 3.
        item = ChatMessage()
        item.author = "Bot"
        item.text = "This one is short again. Or may be not. Span more to see if automatic dimension thing works fine"
        self.addMessage(item)
    }
}

