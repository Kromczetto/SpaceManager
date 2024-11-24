//
//  TemplateList.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 13/09/2024.
//

import SwiftUI
struct TemplateList: View {
    @Binding var selectedOption: String 
    @State private var newTemplate: String = "Nowy szablon"
    @State private var editTemplate: String = ""
    @State private var isNewTemplate: Bool = false
    @FocusState private var isFocused: Bool
    @EnvironmentObject var templateViewModel: TemplateViewModel
    @EnvironmentObject var addNewItemViewModel: AddNewItemViewModel
    var body: some View {
        VStack {
            Picker("Wybierz szablon", selection: $selectedOption) {
                ForEach(templateViewModel.options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: selectedOption) {
                editTemplate = ""
                templateViewModel.isDBReading = true
                if let tempNameTid = templateViewModel.nameTid[templateViewModel.selectedItem] {
                    if !tempNameTid.isEmpty {
                        DispatchQueue.main.async {
                            templateViewModel.getProperties(tid: templateViewModel.nameTid[templateViewModel.selectedItem]!) {
                                print(templateViewModel.template?.propertiesKey)
                                if let temp = templateViewModel.template?.propertiesKey {
                                    addNewItemViewModel.fillArray(prop: temp)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                templateViewModel.getTemplateFromDB() 
            }
            if (selectedOption == templateViewModel.options[0]) {
                TextField(templateViewModel.options[0], text: $editTemplate)
                    .multilineTextAlignment(.center)
                    .focused($isFocused)
                    .onChange(of: isFocused) {
                        if (!isFocused) {
                            if templateViewModel.checkIsNameTaken(name: editTemplate) {
                                addNewItemViewModel.isFail = true
                                addNewItemViewModel.message = "W bazie danych znajduje się już szablon o takiej nazwie. Użyj innej."
                                editTemplate = ""
                            } else {
                                newTemplate = editTemplate
                                templateViewModel.options[0] = newTemplate
                                selectedOption = templateViewModel.options[0]
                            }
                        }
                    }
            } else {
                Text(selectedOption)
            }
        }
    }
}

