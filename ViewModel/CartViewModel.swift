import SwiftUI

class CartViewModel: ObservableObject{
    @Published var openAddItem: Bool = false
    @Published var items = [Item]()

    {
        didSet {
            saveItems()
        }
    }

    let itemsKey: String = "items_list"

    init(){
        getItems()
    }

    func getItems(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey), let savedItems = try? JSONDecoder().decode([Item].self, from: data)
        else { return }
        self.items = savedItems
    }
    
    func addItem(name: String, price: Float){
        items.append(Item(name: name, price: price, quantity: 0, offset: 0, isSwiped: false))
    }

    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
