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
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    var displayServingInfo: String {
        get {
            let servingTotal = numberServings * Double(food.servingSize)
            
            return "\(numberFormatter.string(for: servingTotal) ?? "0") \(food.displayServingSizeUnit)"
        }
    }
    
    var displayList: some View {
        get {
            return VStack {
                Text(date.formatted())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(food.displayName) - \(displayServingInfo)")
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
    
    func loadFromDataStore(data: FoodLogDataStore) -> Void {
        id = data.id
        date = data.date
        food = Food()
        food.loadFromDataStore(data: data.food)
        numberServings = data.numberServings
    }
}
