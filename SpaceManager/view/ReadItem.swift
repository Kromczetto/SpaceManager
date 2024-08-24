import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct ReadItem: View {
    @StateObject var readItemViewModel = ReadItemViewModel()
    @StateObject var readActiveViewModel = ReadActiveViewModel()
    @EnvironmentObject var generatorViewModel: GeneratorViewModel
    
    var messageFromQR: String
    @State var isEdit: Bool = false
    @State var itemName: String = ""
    @State var amount: String = ""
    @State var weight: String = ""
    @State var comment: String = ""
    @State var property: [[String: String]] = []
       
var body: some View {
    VStack {
       if let item = readItemViewModel.item {
           if(!isEdit && !readItemViewModel.isDeleted){
               List{
                   Text("Nazwa: \(item.name)")
                   Text("Ilość: \(item.amount)")
                   Text("Waga: \(item.productWeight)")
                   Text("Uwagi: \(item.commentsToItem)")
                   Text("Dodane przez: \(item.nameOfAdder)")
                   Text("Dodano: \(readItemViewModel.prepairDate(input: item.addDate))")
                   ForEach(0..<item.properties.count, id: \.self) { index in
                       let dict = item.properties[index]
                       ForEach(dict.keys.sorted(), id: \.self) { key in
                           if let value = dict[key] {
                               HStack {
                                   Text("\(key): \(value)")
                               }
                           }
                       }
                   }
                   if(generatorViewModel.num1 != 0){
                       Text("Liczba obrotów: \(generatorViewModel.num1)").onAppear{
                           generatorViewModel.startGeneratingData()
                           generatorViewModel.storeData(itemID: messageFromQR)
                       }
                       .onDisappear {
                          generatorViewModel.stopGeneratingData()
                       }
                   }
                   if(generatorViewModel.num2 != 0){
                       Text("Zużycie prądu: \(generatorViewModel.num2)").onAppear{
                           generatorViewModel.startGeneratingData()
                           generatorViewModel.storeData(itemID: messageFromQR)
                       }
                       .onDisappear {
                          generatorViewModel.stopGeneratingData()
                       }
                   }
                   if(generatorViewModel.workTime != 0){
                       Text("Czas pracy: \(generatorViewModel.workTime)").onAppear{
                           generatorViewModel.startGeneratingData()
                           generatorViewModel.storeData(itemID: messageFromQR)
                       }
                       .onDisappear {
                          generatorViewModel.stopGeneratingData()
                       }
                   }
                 
               }.onAppear{
                   readItemViewModel.fetchItem(with: messageFromQR)
                   readActiveViewModel.fetchItem(with: messageFromQR)
               }
               HStack{
                   BtnModifier(btnText: "Edytuj", btnIcon: "pencil"){
                       isEdit = !isEdit
                   }
                   BtnModifier(btnText: "Usuń", btnIcon: "trash", btnColor: .red){
                       readItemViewModel.delete(id: messageFromQR)
                   }
               }
           }else{
               if(!readItemViewModel.isDeleted){
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
                       BtnModifier(btnText: "Zapisz", btnIcon: "paperplane",
                                   btnColor: .green){
                           readItemViewModel.saveNewData(idOfItem: messageFromQR, nameOfItem: $itemName.wrappedValue,
                                                         amountOfItem: $amount.wrappedValue, weigthOfItem: $weight.wrappedValue, commentsToItem: $comment.wrappedValue)
                           isEdit = !isEdit
                       }
                       BtnModifier(btnText: "Wróć", btnIcon: "arrowshape.turn.up.backward"){
                           isEdit = !isEdit
                       }
                   }
               }else{
                   Spacer()
                   Text("Usunięto produkt")
                       .foregroundColor(.red)
                   Spacer()
               }
           }
       } else {
           Spacer()
           Text("Problemy ze znalezieniem produktu. Spróbuj ponwnie")
               .foregroundColor(.red)
           Spacer()
           
       }
    }
    .padding()
        .onAppear {
            readItemViewModel.fetchItem(with: messageFromQR)
        }
//    BottomMenu()
    }
}

//#Preview {
//    ReadItem(messageFromQR: "1")
//}
