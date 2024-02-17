//
//  FoodLog.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/16/24.
//

import Foundation

struct FoodLogDataStore: Codable {
    var id: UUID
    var date: Date
    var food: FoodDataStore
    var numberServings: Double = 1.0
}

class FoodLog: ObservableObject, Identifiable {
    var id: UUID
    var date: Date
    var food: Food = Food()
    var numberServings: Double = 1.0
    
    init() {
        id = UUID()
        date = Date()
    }
    
    var dataStore: FoodLogDataStore {
        get {
            return FoodLogDataStore(
                id: id,
                date: date,
                food: food.dataStore,
                numberServings: numberServings
            )
        }
    }
    
    func loadFromDataStore(data: FoodLogDataStore) -> Void {
        id = data.id
        date = data.date
        food = Food()
        food.loadFromDataStore(data: data.food)
        numberServings = data.numberServings
    }
}
