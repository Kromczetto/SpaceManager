import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct ReadItemView: View {
    var messageFromQR: String
    @State var isEdit: Bool = false
    @State var adminChange: Bool = false
    @State var uidFromAdmin: String = ""
    @State var first: Bool = true
    @StateObject var readItemViewModel = ReadItemViewModel()
    @StateObject var readActiveViewModel = ReadActiveViewModel()
    @StateObject var statsViewModel = StatsViewModel()
    @EnvironmentObject var favouriteItemViewModel: FavouriteItemViewModel
    @StateObject var apiManagerViewModel = ApiManagerViewModel()
    var body: some View {
    VStack {
       if let item = readItemViewModel.item {
           if (!isEdit && !readItemViewModel.isDeleted) {
               LoadingItem(messageFromQR: messageFromQR,
                           isEdit: $isEdit,
                           isClick: $favouriteItemViewModel.isOnList,
                           adminChange: $adminChange,
                           uidFromAdmin: $uidFromAdmin)
                      .environmentObject(readItemViewModel)
                      .environmentObject(readActiveViewModel)
                      .environmentObject(favouriteItemViewModel)
                      .environmentObject(statsViewModel)
                      .environmentObject(apiManagerViewModel)
                      .onAppear {
                          Task {
                              do {
                                  try await readActiveViewModel.fetchItem(with: messageFromQR)
                              } catch {
                                  print("Error:", error.localizedDescription)
                              }
                          }
                      }
                      .onChange(of:  readActiveViewModel.activeItem?.connection[messageFromQR]) {
                          Task {
                              do {
                                  if let api = readActiveViewModel.activeItem?.connection[messageFromQR] {
                                      print(api)
                                      await apiManagerViewModel.apiSetter(api: api)
                                      if first {
                                          try await apiManagerViewModel.performAPICall()
                                      } else {
                                          apiManagerViewModel.startTimer()
                                      }
                                  }
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
                       .environmentObject(readActiveViewModel)
                       
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
    }
    }
}

