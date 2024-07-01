import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct ReadItem: View {
    @StateObject var readItemViewModel = ReadItemViewModel()
    var messageFromQR: String
    @State var isEdit: Bool = false
    @State var itemName: String = ""
    @State var amount: String = ""
    @State var weight: String = ""
    @State var comment: String = ""
       
var body: some View {
    VStack {
       if let item = readItemViewModel.item {
           if(!isEdit){
               List{
                   Text("Nazwa: \(item.name)")
                   Text("Ilość: \(item.amount)")
                   Text("Waga: \(item.productWeight)")
                   Text("Uwagi: \(item.commentsToItem)")
                   Text("Dodane przez: \(item.nameOfAdder)")
                   Text("Dodano: \(readItemViewModel.prepairDate(input: item.addDate))")
               }.onAppear{
                   readItemViewModel.fetchItem(with: messageFromQR)
               }
               Button{
                   isEdit = !isEdit
               } label:{
                   ZStack{
                       RoundedRectangle(cornerRadius: 20)
                           .foregroundColor(.green)
                           .padding(10)
                           .frame(width: 150, height: 50)
                       Text("Edytuj \(Image(systemName: "pencil"))")
                           .foregroundStyle(.white)
                           .padding()
                           .bold()
                           .font(.system(size: 16))
                   }
               }
           }else{
               List{
                   VStack{
                       HStack{
                           Text("Nazwa:")
                           TextField("Nazwa", text: $itemName)
                               .onAppear{
                                   self.itemName = item.name
                               }
                       }
                       HStack{
                           Text("Ilość:")
                           TextField("Ilość", text: $amount)
                               .onAppear{
                                   self.amount = item.amount
                               }
                       }
                       HStack{
                           Text("Waga:")
                           TextField("Waga", text: $weight)
                               .onAppear{
                                   self.weight = item.productWeight
                               }
                       }
                       HStack{
                           Text("Uwagi:")
                           TextField("Uwagi", text: $comment)
                               .onAppear{
                                   self.comment = item.commentsToItem
                               }
                       }
                   }
               }
               HStack{
                   Button{
                       readItemViewModel.saveNewData(idOfItem: messageFromQR, nameOfItem: $itemName.wrappedValue,
                                                     amountOfItem: $amount.wrappedValue, weigthOfItem: $weight.wrappedValue, commentsToItem: $comment.wrappedValue)
                       isEdit = !isEdit
                   }label:{
                       ZStack{
                           RoundedRectangle(cornerRadius: 20)
                               .foregroundColor(.green)
                               .padding(10)
                               .frame(width: 150, height: 50)
                           Text("Zapisz \(Image(systemName: "paperplane"))")
                               .foregroundStyle(.white)
                               .padding()
                               .bold()
                               .font(.system(size: 16))
                       }
                   }
                   Button{
                       isEdit = !isEdit
                   } label:{
                       ZStack{
                           RoundedRectangle(cornerRadius: 20)
                               .foregroundColor(.blue)
                               .padding(10)
                               .frame(width: 150, height: 50)
                           Text("Wróć \(Image(systemName: "arrowshape.turn.up.backward"))")
                               .foregroundStyle(.white)
                               .padding()
                               .bold()
                               .font(.system(size: 16))
                       }
                   }
               }
           }
       } else {
           Text("Problemy ze znalezieniem produktu")
       }
    
           
    }
    .padding()
        .onAppear {
            readItemViewModel.fetchItem(with: messageFromQR)
        }
    BottomMenu()
    }
}

#Preview {
    ReadItem(messageFromQR: "1")
}
