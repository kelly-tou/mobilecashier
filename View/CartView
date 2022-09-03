import SwiftUI

struct CartView: View {
    @StateObject var cartData = CartViewModel()
    @State var itemName: String = ""
    @State var itemPrice: Float = 0
    @EnvironmentObject var cartViewModel: CartViewModel
    var body: some View {
        VStack{
            HStack(spacing: 20){

                Spacer()
                
                Text("My Items")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .offset(x: 40)
                
                Spacer()
                
                Button {
//                    alertTF(title: "Add a New Item", hintText1: "Name", hintText2: "Price", primaryTitle: "Cancel", secondaryTitle: "Save")})
                    cartViewModel.openAddItem.toggle()
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .heavy))
                        .foregroundColor(.white)
                        .padding(.vertical, 9)
                        .padding(.horizontal, 17)
                        .background(.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(spacing: 0){
                    ForEach(cartData.items){item in
                        ItemView(item: $cartData.items[getIndex(item: item)], items: $cartData.items)
                        
                        // new findings: the line of code above does not run when there isn't any code/typed out list items in the cart view model list, for example it does not apply to appended items
                        //new findings: foreach does run, but ItemView does not execute - issue with binding? - update not an issue with binding
                        //new findings: brute force for each and reset view
                    }
                }
            }
            VStack{
                HStack{
                    Text("Total")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                .padding([.top,.horizontal])
                
                Button(action:{clear()}){
                    Text("Clear")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(.blue)
                        .cornerRadius(15)
                }
            }
            .background(Color.white)
        }
        .background(Color("gray").ignoresSafeArea())
        .fullScreenCover(isPresented: $cartViewModel.openAddItem) {
            AddView()
                .environmentObject(cartViewModel)
        }
    }
    func getIndex(item: Item)->Int{
        return $cartData.items.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
    }
    func getPrice(value: Float)->String{
        let format = NumberFormatter()
        format.numberStyle = .currency
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    func calculateTotalPrice()->String{
        var price : Float = 0
        cartData.items.forEach { (item) in
            price += Float(item.quantity) * item.price
        }
        return getPrice(value: price)
    }
    func clear(){
        for i in cartData.items.indices {
            cartData.items[i].quantity = 0
        }
    }
    
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView().environmentObject(CartViewModel())
    }
}
