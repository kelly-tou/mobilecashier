import SwiftUI

struct CartView: View {
    @State var itemName: String = ""
    @State var itemPrice: Float = 0
    @EnvironmentObject var cartViewModel: CartViewModel
    var body: some View {
        VStack{
            HStack(spacing: 20){

                Spacer()
                
                Text("My Cart")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .offset(x: 35)
                
                Spacer()
                
                Button {
                    cartViewModel.openAddItem.toggle()
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 9)
                        .padding(.horizontal, 17)
                        .background(Color(red: 255 / 255, green: 123 / 255, blue: 0 / 255))
                        .cornerRadius(10)
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(spacing: 0){
                    ForEach(cartViewModel.items){item in
                        ItemView(item: $cartViewModel.items[getIndex(item: item)], items: $cartViewModel.items)
                            .padding(.bottom, 10)
                    }
                }
            }
            .padding(.horizontal, 35)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 35)
                    .fill(Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255))
                    .padding(.horizontal, 15)
            )
            VStack{
                HStack{
                    Text("Total")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(cartViewModel.calculateTotalPrice())
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 25)
                .padding(.top)
                
                Button(action:{
//                    clear()
                    cartViewModel.openCheckoutView.toggle()
                }){
                    Text("Checkout")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .foregroundColor(.white)
                        .background(Color(red: 255 / 255, green: 123 / 255, blue: 0 / 255))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
            }
        }
        .background(Color(.white).ignoresSafeArea())
        .fullScreenCover(isPresented: $cartViewModel.openAddItem) {
            AddView()
                .environmentObject(cartViewModel)
        }
        .fullScreenCover(isPresented: $cartViewModel.openCheckoutView) {
            CheckoutView()
                .environmentObject(cartViewModel)
        }
    }
    
    func getIndex(item: Item)->Int{
        return $cartViewModel.items.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
    }
}
    
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView().environmentObject(CartViewModel())
    }
}
