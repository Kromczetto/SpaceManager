import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct ReadItem: View {
    @StateObject var readItemViewModel = ReadItemViewModel()
    var messageFromQR: String
    @State var isEdit: Bool = false
    @State var itemName: String = ""
       
var body: some View {
    VStack {
       if let item = readItemViewModel.item {
           if(!isEdit){
               VStack{
                   Text("Nazwa produktu: \(item.name)")
                   Text("Ilość produktu: \(item.amount)")
                   Text("Dodane przez: \(item.nameOfAdder)")
                   Text("Waga: \(item.productWeight)")
                   Text("Uwagi: \(item.commentsToItem)")
                   Text("Dodano: \(readItemViewModel.prepairDate(input: item.addDate))")
               }.onAppear{
                   readItemViewModel.fetchItem(with: messageFromQR)
               }
           }else{
               TextField("Nazwa", text: $itemName)
                   .onAppear{
                       self.itemName = item.name
                   }
               Button{
                   readItemViewModel.saveNewData()
               }label:{
                   Text("Zapisz")
               }
           }
       } else {
           Text("Problemy ze znalezieniem produktu")
       }
       Button{
           isEdit = !isEdit
       } label:{
           Text("edit")
       }
           
    }
    .padding()
        .onAppear {
            readItemViewModel.fetchItem(with: messageFromQR)
        }
    }
}

#Preview {
    ReadItem(messageFromQR: "1")
}
