//
//  LogFoodView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct LogFoodView: View {
    @Binding var showNewForm: Bool
    @State var showSearchView: Bool = false
    @ObservedObject var foodLog: FoodLog
    @ObservedObject var userStore: UserStore
    private var editMode: Bool
    private var showDate: Bool
    
    init(showNewForm: Binding<Bool>, userStore: UserStore, editMode: Bool = false, showDate: Bool = false, foodLog: ObservedObject<FoodLog> = ObservedObject(initialValue: FoodLog())) {
        self._foodLog = foodLog
        self.userStore = userStore
        self._showNewForm = showNewForm
        self.editMode = editMode
        self.showDate = showDate
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Details")) {
                        if (showDate) {
                            DatePicker("Date", selection: $foodLog.date)
                                .datePickerStyle(.compact)
                        }
                        Button(action: {
                            showSearchView = true
                        }, label: {
                            HStack {
                                Text(foodLog.food.name == "" ? "Search for Food" : foodLog.food.name)
                                Spacer()
                                Image(systemName: "magnifyingglass")
                            }
                        })
                            .foregroundColor(.primary)
                        HStack {
                            Text("Servings")
                            Spacer()
                            Text("\(foodLog.displayServings)")
                            Stepper("", value: $foodLog.numberServings, in: 0.50...1000, step: 0.50)
                                .fixedSize()
                        }
                    }
                }
            }
            .navigationTitle("Log Food")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showNewForm = false
                    }
                    .fontWeight(.bold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if (editMode) {
                            userStore.saveData()
                        } else {
                            userStore.addFoodLogItem(item: foodLog)
                        }
                        
                        showNewForm = false
                    }
                    .disabled(foodLog.food.name == "")
                    .fontWeight(.bold)
                }
            }
            .sheet(isPresented: $showSearchView) {
                SearchFoodView(showSearchView: $showSearchView, userStore: userStore, foodLog: ObservedObject(initialValue: foodLog))
            }
        }
    }
}

#Preview {
    LogFoodView(showNewForm: .constant(true), userStore: UserStore())
}
