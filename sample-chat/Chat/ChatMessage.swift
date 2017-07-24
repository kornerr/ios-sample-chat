
import Foundation

struct ChatMessage : CustomStringConvertible {
    var date = Date()
    var author = ""
    var text = ""
    // TODO: image(s)
    // TODO: geolocation

    var description: String {
        return
            "ChatMessage(date: '\(date)' " +
            "author: '\(author)' " +
            "text: '\(text)')"
    }
}

