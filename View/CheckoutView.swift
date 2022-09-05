import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @Environment(\.self) var env
    @Environment(\.presentationMode) var presentationMode
    @State var customerPayment: String = ""
    var body: some View {
        VStack{
            Text("Checkout")
                .font(.title3.bold())
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
                .padding(.bottom)
            
            HStack{
                Text("Purchase Total")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Spacer()
                Text(cartViewModel.calculateTotalPrice())
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
            }
            
            HStack{
                Text("Payment Amount")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Spacer()
                Text("$")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                TextField("", text: $customerPayment)
                    .frame(width: 80)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.trailing)
            }
            .padding(.bottom, 2)
            
            HStack{
                HStack{
                    Text("Change")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(calculateChange())
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                }
            }
            
            Spacer()
                
            Button{
                clear()
                env.dismiss()
            } label: {
                Text("Start a New Order")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .foregroundColor(.white)
                    .background(Color(red: 255 / 255, green: 123 / 255, blue: 0 / 255))
                    .cornerRadius(10)
            }
        }
        .padding()
    }
    func calculateChange() -> String {
        if customerPayment == "" {
            return "$0.00"
        }
        else{
            let customerPay: Float = Float(customerPayment) ?? 0
            return cartViewModel.getPrice(value: (customerPay - cartViewModel.calculateFinalPrice()))
        }
    }
    
    func clear(){
        for i in cartViewModel.items.indices {
            cartViewModel.items[i].quantity = 0
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView().environmentObject(CartViewModel())
    }
}
