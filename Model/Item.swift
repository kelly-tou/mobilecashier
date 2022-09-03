import SwiftUI

struct Item: Identifiable, Codable {
    var id = UUID().uuidString
    var name : String
    var price: Float
    var quantity: Int
    var offset: CGFloat
    var isSwiped: Bool
    
    func updateCompletion() -> Item {
        return Item(id: id, name: name, price: price, quantity: quantity, offset: offset, isSwiped: isSwiped)
    }
}
