import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct ReadItemView: View {
    var messageFromQR: String
    @State var isEdit: Bool = false
    @StateObject var readItemViewModel = ReadItemViewModel()
    @StateObject var readActiveViewModel = ReadActiveViewModel()
    @EnvironmentObject var generatorViewModel: GeneratorViewModel
    var body: some View {
    VStack {
       if let item = readItemViewModel.item {
           if (!isEdit && !readItemViewModel.isDeleted) {
               ReadItem(messageFromQR: messageFromQR, isEdit: $isEdit)
                   .environmentObject(readItemViewModel)
                   .environmentObject(readActiveViewModel)
                   .environmentObject(generatorViewModel)
           } else {
               if (!readItemViewModel.isDeleted) {
                   EditField(messageFromQR: messageFromQR, itemName: item.name, amount: item.amount,
                             weight: item.productWeight, comment: item.commentsToItem, isEdit: $isEdit)
                       .environmentObject(readItemViewModel)
                   
               } else {
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
    }
}

