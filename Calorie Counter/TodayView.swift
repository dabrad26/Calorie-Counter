//
//  TodayView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI
import Charts

struct PieChartItem: Identifiable {
    let id = UUID()
    let title: String
    let percent: Double
}

struct TodayView: View {
    @ObservedObject var userStore: UserStore
    @State private var showNewForm = false
    @ObservedObject private var editItem: FoodLog = FoodLog()
    
    init(userStore: UserStore) {
        self.userStore = userStore
    }
    
    private func getTodayItems() -> [FoodLog] {
        var list: [FoodLog] = []
        
        userStore.foodLogs.forEach { item in
            if (Calendar.current.isDateInToday(item.date)) {
                list.append(item)
            }
        }
        
        return list
    }
    
    private func getFoodList(list: [FoodLog]) -> some View {
        return ForEach(list) { foodLog in
            Button(action: {
                editItem.loadFromDataStore(data: foodLog.dataStore)
                showNewForm = true
            }, label: {
                foodLog.displayList
            })
            .foregroundStyle(.primary)
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
    
    private func getDetailInfo(_ label: String, _ value: Double, _ unit: String) -> some View {
        let hideData = value == 0.0
        
        return VStack {
            Text(label)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(hideData ? "-" : numberFormatter.string(for: value) ?? "0") \(hideData ? "" : unit)")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top)
    }
    
    private func getCalorieChart(list: [FoodLog] ) -> some View {
        let allowedCalories = Double(userStore.dailyCalories) ?? Double(userStore.defaultDailyCalories)
        
        let totalCalories = list.reduce(0, { x, y in
            x + y.totalCalories
        })
        
        let totalFat = list.reduce(0, { x, y in
            x + y.totalFat
        })
        
        let totalProtein = list.reduce(0, { x, y in
            x + y.totalProtein
        })
        
        let totalSugar = list.reduce(0, { x, y in
            x + y.totalSugar
        })
        
        let totalCarbs = list.reduce(0, { x, y in
            x + y.totalCarbs
        })
        
        let totalFiber = list.reduce(0, { x, y in
            x + y.totalFiber
        })
        
        let totalSodium = list.reduce(0, { x, y in
            x + y.totalSodium
        })
        
        let totalCholesterol = list.reduce(0, { x, y in
            x + y.totalCholesterol
        })
        
        let consumed = totalCalories / (Double(userStore.dailyCalories) ?? 1)
        let overage = totalCalories > Double(userStore.dailyCalories) ?? 1
        
        var items: [PieChartItem] = [
            .init(title: "Consumed", percent: consumed),
            .init(title: "Available", percent: 1.0 - consumed),
        ]
        
        var chartColors: [Color] = [
            Theme.brandPrimary,
            Theme.brandAccent3
        ]
        
        if (overage) {
            items = [
                .init(title: "Consumed", percent: 1.0),
            ]
            
            chartColors = [
                .red
            ]
        }
        
        return VStack {
            ZStack {
                Chart(items) { item in
                    SectorMark(
                        angle: .value(
                            Text(verbatim: item.title),
                            item.percent
                        ),
                        innerRadius: .ratio(0.6),
                        angularInset: 8
                    )
                    .foregroundStyle(
                        by: .value(
                            Text(verbatim: item.title),
                            item.title
                        )
                    )
                }
                .chartForegroundStyleScale(
                    domain: items.map  { $0.title },
                    range: chartColors
                )
                .chartLegend(.hidden)
                .frame(minHeight: 250)
                
                VStack(alignment:.center) {
                    Text("\(numberFormatter.string(for: totalCalories) ?? "0") /")
                        .font(.title2)
                        .foregroundColor(.primary)
                    
                    
                    Text(numberFormatter.string(for: allowedCalories) ?? "0")
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            HStack {
                getDetailInfo("Calories", totalCalories, "Kcal")
                getDetailInfo("Fat", totalFat, "G")
                getDetailInfo("Protein", totalProtein, "G")
            }
            HStack {
                getDetailInfo("Sugar", totalSugar, "G")
                getDetailInfo("Fiber", totalFiber, "G")
                getDetailInfo("Sodium", totalSodium, "MG")
            }
            HStack {
                getDetailInfo("Carbohydrates", totalCarbs, "G")
                getDetailInfo("Cholesterol", totalCholesterol, "MG")
            }
        }
    }
    
    var body: some View {
        let todayList = getTodayItems()
        
        NavigationStack {
            List {
                Section {
                    getCalorieChart(list: todayList)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                
                if (!todayList.isEmpty) {
                    Section("Today's Food") {
                        getFoodList(list: todayList)
                            .listRowBackground(Color(UIColor.tertiarySystemGroupedBackground))
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(GroupedListStyle())
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log Food") {
                        editItem.clearData()
                        showNewForm = true
                    }
                    .fontWeight(.bold)
                    .foregroundStyle(Theme.brandPrimary)
                }
            }
            .sheet(isPresented: $showNewForm) {
                let editMode: Bool = editItem.food.name != ""
                
                LogFoodView(showNewForm: $showNewForm, userStore: userStore, editMode: editMode, showDate: false, foodLog: editMode ? ObservedObject(initialValue: editItem) : nil)
            }
        }
    }
}

#Preview {
    TodayView(userStore: UserStore())
}
