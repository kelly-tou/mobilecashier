import SwiftUI

struct ItemView: View {
    @StateObject var cartData = CartViewModel()
    @Binding var item: Item
    @Binding var items: [Item]
// changing these to state variables prevents the quantity adding from working
    var body: some View {
        ZStack{
            HStack{
                Spacer()
                Button(action: {
                    withAnimation(.easeIn){deleteItem()}
                }){
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 90, height: 98.65)
                }
            }
            .background(.blue)

            HStack(spacing: 15){
                VStack(alignment: .leading, spacing: 10){
                    Text(item.name)
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    HStack(spacing: 15){
                        Text(getPrice(value: item.price))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Spacer(minLength: 0)
                        Button(action: {
                            if item.quantity > 0{item.quantity -= 1}
                        }){
                            Image(systemName: "minus")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(.black)
                        }
                        Text("\(item.quantity)")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.black.opacity(0.06))
                        Button(action: {item.quantity += 1}){
                            Image(systemName: "plus")
                                .font(.system(size: 16, weight: .heavy))
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding()
                .background(.white)
                .contentShape(Rectangle())
                .offset(x: item.offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
            }
        }
    }
    func getPrice(value: Float)->String{
        let format = NumberFormatter()
        format.numberStyle = .currency
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.width < 0{
            if item.isSwiped{
                item.offset = value.translation.width
            }
            else{
                item.offset = value.translation.width
            }
        }
    }
    func onEnd(value: DragGesture.Value){
        withAnimation(.easeOut){
            if value.translation.width<0{
                if -value.translation.width > UIScreen.main.bounds.width / 2{
                    item.offset = -1000
                    deleteItem()
                }
                else if -item.offset > 50{
                    item.isSwiped = true
                    item.offset = -90
                }
                else{
                    item.isSwiped = false
                    item.offset = 0
                }
            }
            else{
                item.isSwiped = false
                item.offset = 0
            }
        }
    }
    func deleteItem(){
        items.removeAll() { (item) -> Bool in
            return self.item.id == item.id
        }
    }
}
