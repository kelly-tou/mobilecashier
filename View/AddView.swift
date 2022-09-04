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
                .padding(.bottom)
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
                HStack{
                    Text("$")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                    
                    TextField("", text: $itemPrice)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                        .keyboardType(.decimalPad)
                }
            }
            Divider()
            
            Button{
                saveButtonPressed()
            } label: {
                Text("Save")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .foregroundColor(.white)
                    .background(Color(red: 255 / 255, green: 123 / 255, blue: 0 / 255))
                    .cornerRadius(10)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 10)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
    
    func saveButtonPressed() {
        if isNameValid() && isPriceValid() {
            cartViewModel.addItem(name: itemName, price: Float(itemPrice) ?? 0)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func isNameValid() -> Bool {
        if itemName.isEmpty {
            return false
        }
        return true
    }
    
    func isPriceValid() -> Bool {
        for char in itemPrice {
            let scalarValues = String(char).unicodeScalars
            let charAscii = scalarValues[scalarValues.startIndex].value
            if (charAscii != 44 && charAscii != 46) && (charAscii < 48 || charAscii > 57) {
                return false
            }
        }
        return true
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView().environmentObject(CartViewModel())
    }
}
