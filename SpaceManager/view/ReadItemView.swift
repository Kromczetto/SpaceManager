import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct ReadItemView: View {
    var messageFromQR: String
    @State var isEdit: Bool = false
    @State var adminChange: Bool = false
    @State var uidFromAdmin: String = ""
    @StateObject var readItemViewModel = ReadItemViewModel()
    @StateObject var readActiveViewModel = ReadActiveViewModel()
    @StateObject var statsViewModel = StatsViewModel()
   // @EnvironmentObject var generatorViewModel: GeneratorViewModel
    @EnvironmentObject var favouriteItemViewModel: FavouriteItemViewModel
    @StateObject var apiManagerViewModel = ApiManagerViewModel()
    var body: some View {
    VStack {
       if let item = readItemViewModel.item {
           if (!isEdit && !readItemViewModel.isDeleted) {
               ReadItem(messageFromQR: messageFromQR, 
                        isEdit: $isEdit,
                        isClick: $favouriteItemViewModel.isOnList,
                        adminChange: $adminChange,
                        uidFromAdmin: $uidFromAdmin)
                   .environmentObject(readItemViewModel)
                   .environmentObject(readActiveViewModel)
                   //.environmentObject(generatorViewModel)
                   .environmentObject(favouriteItemViewModel)
                   .environmentObject(statsViewModel)
                   .environmentObject(apiManagerViewModel)
                   .onAppear {
                       Task {
                           do {
                               try await apiManagerViewModel.performAPICall()
                              
                               print("addd")
                           } catch {
                               print("Error:", error.localizedDescription)
                           }
                       }
                   }
           } else {
               if (!readItemViewModel.isDeleted) {
                   EditField(messageFromQR: messageFromQR, itemName: item.name, amount: item.amount,
                             weight: item.productWeight, comment: item.commentsToItem, adminChange: adminChange, changeUid: uidFromAdmin, isEdit: $isEdit)
                       .environmentObject(readItemViewModel)
                       .environmentObject(favouriteItemViewModel)
                       
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
        if adminChange {
            statsViewModel.readStats()
            readItemViewModel.fetchItemAsAdmin(with: messageFromQR, uid: uidFromAdmin)
            print("admin checking..")
        } else {
            statsViewModel.readStats()
            readItemViewModel.fetchItem(with: messageFromQR)
        }
        //favouriteItemViewModel.isOnFavouriteList(id: messageFromQR)
    }
    }
}

