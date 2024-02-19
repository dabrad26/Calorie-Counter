//
//  UserStore.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/16/24.
//

import Foundation

struct JsonStoreData: Codable {
    var dailyCalories: String
    var foods: [FoodDataStore]
    var foodLogs: [FoodLogDataStore]
}

class UserStore: ObservableObject {
    let defaultDailyCalories: Int = 2000
    @Published var dailyCalories: String
    @Published var foods: [Food] = []
    @Published var foodLogs: [FoodLog] = []
    var lastStoredJson: String = ""
    
    init() {
        dailyCalories = String(defaultDailyCalories)
        let userData = UserDefaults.standard.string(forKey: "user_store")
        initializeData(userData: userData)
    }
    
    private func initializeData(userData: String?) -> Void {
        if (userData != nil) {
            lastStoredJson = userData ?? ""
            let jsonData = userData!.data(using: .utf8)
            
            do {
                let data: JsonStoreData = try JSONDecoder().decode(JsonStoreData.self, from: jsonData!)
                
                data.foods.forEach { item in
                    let newFood = Food()
                    newFood.loadFromDataStore(data: item)
                    foods.append(newFood)
                }
                
                data.foodLogs.forEach { item in
                    let newFoodLog = FoodLog()
                    newFoodLog.loadFromDataStore(data: item)
                    foodLogs.append(newFoodLog)
                }
                
                dailyCalories = data.dailyCalories
                
                sortFoodLog()
            } catch {
                print("ERROR: Unable to get JSON data on load: \(error.localizedDescription)")
            }
        }
    }
    
    private func sortFoodLog() -> Void {
        foodLogs.sort(by: { $0.date.compare($1.date) == .orderedDescending })
    }
    
    func saveData() -> Void {
        let data = JsonStoreData(dailyCalories: dailyCalories, foods: foods.map({ item in
            return item.dataStore
        }), foodLogs: foodLogs.map({ item in
            return item.dataStore
        }))
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            let jsonString = String(data: jsonData, encoding: .utf8)
            lastStoredJson = jsonString ?? ""
            UserDefaults.standard.setValue(jsonString, forKey: "user_store")
            
            dailyCalories = dailyCalories
            foods = foods
            foodLogs = foodLogs
        } catch {
            print("ERROR: Unable to save JSON data: \(error.localizedDescription)")
        }
    }
    
    func clearData() -> Void {
        dailyCalories = String(defaultDailyCalories)
        foods = []
        foodLogs = []
        saveData()
    }
    
    func updateFoodItem(food: Food) -> Void {
        let foundIndex = foods.firstIndex(where: { item in
            return item.id == food.id
        })
        
        if (foundIndex != nil) {
            let newFood = Food()
            newFood.loadFromDataStore(data: food.dataStore)
            foods[foundIndex!] = newFood
            saveData()
        }
    }
    
    func updateFoodLogItem(foodLog: FoodLog) -> Void {
        let foundIndex = foodLogs.firstIndex(where: { item in
            return item.id == foodLog.id
        })
        
        if (foundIndex != nil) {
            let newFoodLog = FoodLog()
            newFoodLog.loadFromDataStore(data: foodLog.dataStore)
            foodLogs[foundIndex!] = newFoodLog
            saveData()
        }
    }
    
    func addFoodItem(item: Food) -> Void {
        foods.insert(item, at: 0)
        saveData()
    }
    
    func addFoodLogItem(item: FoodLog) -> Void {
        foodLogs.insert(item, at: 0)
        sortFoodLog()
        saveData()
    }
    
    func removeFoodItem(offsets: IndexSet) {
        foods.remove(atOffsets: offsets)
        saveData()
    }
    
    func removeFoodLogItem(item: FoodLog) {
        let index = foodLogs.firstIndex(where: { $0.id == item.id })
        
        if (index != nil) {
            foodLogs.remove(at: index!)
        }
        
        saveData()
    }
}
