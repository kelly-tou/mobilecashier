import SwiftUI

class CartViewModel: ObservableObject{
    @Published var openAddItem: Bool = false
    @Published var openCheckoutView: Bool = false
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
    
    func getPrice(value: Float)->String{
        let format = NumberFormatter()
        format.numberStyle = .currency
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    
    func calculateTotalPrice()->String{
        var price : Float = 0
        items.forEach { (item) in
            price += Float(item.quantity) * item.price
        }
        return getPrice(value: price)
    }
    
    func calculateFinalPrice()->Float{
        var price : Float = 0
        items.forEach { (item) in
            price += Float(item.quantity) * item.price
        }
        return price
    }
}
