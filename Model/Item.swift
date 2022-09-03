import SwiftUI

struct Item: Identifiable, Codable {
    var id = UUID().uuidString
    var name : String
    var price: Float
    var quantity: Int
    var offset: CGFloat
    var isSwiped: Bool
}
