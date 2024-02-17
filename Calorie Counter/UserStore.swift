//
//  UserStore.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/16/24.
//

import Foundation

struct JsonStoreData: Codable {
    var foods: [FoodDataStore]
    var foodLogs: [FoodLogDataStore]
}

class UserStore: ObservableObject {
    @Published var foods: [Food] = []
    @Published var foodLogs: [FoodLog] = []
    var lastStoredJson: String = ""
    
    init() {
        let userData = UserDefaults.standard.string(forKey: "user_store")
        initializeDate(userData: userData)
    }
    
    private func initializeDate(userData: String?) -> Void {
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
            } catch {
                print("ERROR: Unable to get JSON data on load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveData() -> Void {
        let data = JsonStoreData(foods: foods.map({ item in
            return item.dataStore
        }), foodLogs: foodLogs.map({ item in
            return item.dataStore
        }))
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            let jsonString = String(data: jsonData, encoding: .utf8)
            lastStoredJson = jsonString ?? ""
            UserDefaults.standard.setValue(jsonString, forKey: "user_store")
        } catch {
            print("ERROR: Unable to save JSON data: \(error.localizedDescription)")
        }
    }
    
    func addFoodItem(item: Food) -> Void {
        foods.append(item)
        saveData()
    }
    
    func addFoodLogItem(item: FoodLog) -> Void {
        foodLogs.append(item)
        saveData()
    }
    
    func removeFoodItem(offsets: IndexSet) {
        foods.remove(atOffsets: offsets)
        saveData()
    }
    
    func removeFoodLogItem(offsets: IndexSet) {
        foodLogs.remove(atOffsets: offsets)
        saveData()
    }
}
