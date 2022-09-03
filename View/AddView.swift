import SwiftUI

struct AddView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @Environment(\.self) var env
    @Environment(\.presentationMode) var presentationMode
    @State var itemName: String = ""
    @State var itemPrice: String = ""
    var body: some View {
        VStack(spacing: 12){
            Text("Add a New Item")
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
            VStack(alignment: .leading, spacing: 12) {
                Text("Item Name")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("", text: $itemName)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
            }
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Item Price")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("", text: $itemPrice)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 10)
            }
            Divider()
            
            Button{
                cartViewModel.addItem(name: itemName, price: Float(itemPrice) ?? 0)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .foregroundColor(.white)
                    .background{
                        Capsule()
                    }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 10)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView().environmentObject(CartViewModel())
    }
}
