//
//  HistoryView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct DiaryView: View {
    @ObservedObject var userStore: UserStore
    @State private var showNewForm = false
    @ObservedObject private var editItem: FoodLog = FoodLog()
    
    init(userStore: UserStore) {
        self.userStore = userStore
    }
    
    private func setupDateDivisionSections() -> some View {
        var dateDivision: [String: [FoodLog]] = [:]
        var keyOrder: [String] = []
        
        userStore.foodLogs.forEach { originalLog in
            let foodLog = FoodLog()
            foodLog.loadFromDataStore(data: originalLog.dataStore)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            let dateString = dateFormatter.string(for: foodLog.date) ?? ""
            
            if (dateDivision.keys.contains(dateString)) {
                dateDivision[dateString]?.append(foodLog)
            } else {
                keyOrder.append(dateString)
                dateDivision[dateString] = [foodLog]
            }
        }
        
        return ForEach(keyOrder, id: \.self) { key in
            getSection(list: dateDivision[key]!, label: key)
        }
    }
    
    private func getSection(list: [FoodLog], label: String) -> some View {
        let totalCalories = list.reduce(0, { x, y in
            x + y.totalCalories
        })
        
        let allowedCalories = Double(userStore.dailyCalories) ?? Double(userStore.defaultDailyCalories)
        
        return Section(header: VStack {
            Text(label)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(numberFormatter.string(for: totalCalories) ?? "0") / \(numberFormatter.string(for: allowedCalories) ?? "0")")
                .font(.subheadline)
                .foregroundColor(totalCalories <= allowedCalories ? .green : .red)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
            .padding(.bottom)
        ) {
            ForEach(list) { foodLog in
                Button(action: {
                    editItem.loadFromDataStore(data: foodLog.dataStore)
                    showNewForm = true
                }, label: {
                    foodLog.displayList
                })
                .foregroundColor(.primary)
            }
            .onDelete(perform: { indexSet in
                indexSet.forEach { index in
                    let foundItem: FoodLog? = list[index]
                    
                    if (foundItem != nil) {
                        userStore.removeFoodLogItem(item: foundItem!)
                    }
                }
            })
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if (userStore.foodLogs.count == 0) {
                    NoItemsView()
                } else {
                    List {
                        setupDateDivisionSections()
                    }
                }
            }
            .navigationTitle("Diary")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log Food") {
                        editItem.clearData()
                        showNewForm = true
                    }
                    .fontWeight(.bold)
                }
            }
            .sheet(isPresented: $showNewForm) {
                let editMode: Bool = editItem.food.name != ""
                
                LogFoodView(showNewForm: $showNewForm, userStore: userStore, editMode: editMode, showDate: true, foodLog: editMode ? ObservedObject(initialValue: editItem) : nil)
            }
        }
    }
}

#Preview {
    DiaryView(userStore: UserStore())
}
