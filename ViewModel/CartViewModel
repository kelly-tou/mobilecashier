import SwiftUI

class CartViewModel: ObservableObject{
    @Published var openAddItem: Bool = false
    @Published var items = [Item]()
    
    func addItem(name: String, price: Float){
        items.append(Item(name: name, price: price, quantity: 0, offset: 0, isSwiped: false))
    }
}
