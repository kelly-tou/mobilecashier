import SwiftUI

struct CartView: View {
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
                    ForEach(cartViewModel.items){item in
                        ItemView(item: $cartViewModel.items[getIndex(item: item)], items: $cartViewModel.items)
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
        return $cartViewModel.items.firstIndex { (item1) -> Bool in
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
        cartViewModel.items.forEach { (item) in
            price += Float(item.quantity) * item.price
        }
        return getPrice(value: price)
    }
    func clear(){
        for i in cartViewModel.items.indices {
            cartViewModel.items[i].quantity = 0
        }
    }
}
    
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView().environmentObject(CartViewModel())
    }
}
