//
//  FoodLog.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/16/24.
//

import Foundation
import SwiftUI

struct FoodLogDataStore: Codable {
    var id: UUID
    var date: Date
    var food: FoodDataStore
    var numberServings: Double = 1.0
}

class FoodLog: ObservableObject, Identifiable {
    var id: UUID
    var date: Date
    @Published var food: Food = Food()
    @Published var numberServings: Double = 1.0
    
    init() {
        id = UUID()
        date = Date()
    }
    
    var displayServingInfo: String {
        get {
            let servingTotal = numberServings * Double(food.servingSize)
            
            return "\(numberFormatter.string(for: servingTotal) ?? "0") \(food.displayServingSizeUnit)"
        }
    }
    
    var totalCalories: Double {
        get {
            return Double(food.calories) * numberServings
        }
    }
    
    var totalFat: Double {
        get {
            return Double(food.fat) * numberServings
        }
    }
    
    var totalProtein: Double {
        get {
            return Double(food.protein) * numberServings
        }
    }
    
    var totalSugar: Double {
        get {
            return Double(food.sugar) * numberServings
        }
    }
    
    var totalCarbs: Double {
        get {
            return Double(food.carbohydrate) * numberServings
        }
    }
    
    var totalFiber: Double {
        get {
            return Double(food.fiber) * numberServings
        }
    }
    
    var totalSodium: Double {
        get {
            return Double(food.sodium) * numberServings
        }
    }
    
    var totalCholesterol: Double {
        get {
            return Double(food.cholesterol) * numberServings
        }
    }
    
    var displayList: some View {
        get {
            var stringParts: [String] = [];
            
            if (food.caloriesString != "" && stringParts.count < 5) {
                stringParts.append("\(numberFormatter.string(for: totalCalories) ?? "0") Kcal")
            }
            
            if (food.fatString != "" && stringParts.count < 5) {
                stringParts.append("\(numberFormatter.string(for: Double(food.fat) * numberServings) ?? "0")G fat")
            }
            
            if (food.sugarString != "" && stringParts.count < 5) {
                stringParts.append("\(numberFormatter.string(for: Double(food.sugar) * numberServings) ?? "0")G sugar")
            }
            
            if (food.proteinString != "" && stringParts.count < 5) {
                stringParts.append("\(numberFormatter.string(for: Double(food.protein) * numberServings) ?? "0")G protein")
            }
            
            if (food.fiberString != "" && stringParts.count < 5) {
                stringParts.append("\(numberFormatter.string(for: Double(food.fiber) * numberServings) ?? "0")G fiber")
            }
            
            if (food.carbohydrateString != "" && stringParts.count < 5) {
                stringParts.append("\(numberFormatter.string(for: Double(food.carbohydrate) * numberServings) ?? "0")G carbs")
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .none
            
            return VStack {
                Text("\(food.displayName) - \(displayServingInfo)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(stringParts.joined(separator: ", "))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(dateFormatter.string(for: date) ?? "")
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    var displayServings: String {
        get {
            return numberFormatter.string(for: numberServings) ?? "0"
        }
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
    
    func clearData() -> Void {
        id = UUID()
        date = Date()
        food = Food()
        numberServings = 1
    }
    
    func loadFromDataStore(data: FoodLogDataStore) -> Void {
        id = data.id
        date = data.date
        food = Food()
        food.loadFromDataStore(data: data.food)
        numberServings = data.numberServings
    }
}
