//
//  Food.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/16/24.
//

import Foundation

enum ServingSizeUnit {
    case g
    case each
    case other
}


struct FoodDataStore: Codable {
    var id: UUID
    var name: String = ""
    var brand: String = ""
    var servingSizeUnit: String = ""
    var calories: Int = 0
    var fat: Int = 0
    var protein: Int = 0
    var carbohydrate: Int = 0
    var fiber: Int = 0
    var sodium: Int = 0
    var cholesterol: Int = 0
}

class Food: ObservableObject, Identifiable {
    /** ID of the food (random or fdcId from API)  */
    var id: UUID
    /** Name of food item (Description) */
    @Published var name: String = ""
    /** Brand of item (optional) */
    var brand: String = ""
    /** Serving size unit (from API) */
    var servingSizeUnit: ServingSizeUnit = ServingSizeUnit.g
    /** Calories (energy) in KCAL */
    @Published var calories: Int = 0
    /** Total Fat in G */
    var fat: Int = 0
    /** Total Protein in G */
    var protein: Int = 0
    /** Total Carbohydrate in G */
    var carbohydrate: Int = 0
    /** Total Fiber in G */
    var fiber: Int = 0
    /** Total Sodium in MG */
    var sodium: Int = 0
    /** Total Cholesterol in MG */
    var cholesterol: Int = 0
    
    init() {
        id = UUID()
    }
    
    private func isNumber(_ value: String) -> Bool {
        return Int(value) != nil
    }
    
    var caloriesString: String {
        get {
            return calories > 0 ? String(calories) : ""
        }
        set (newValue) {
            calories = isNumber(newValue) ? Int(newValue) ?? 0 : 0
        }
    }
    
    var fatString: String {
        get {
            return fat > 0 ? String(fat) : ""
        }
        set (newValue) {
            fat = isNumber(newValue) ? Int(newValue) ?? 0 : 0
        }
    }
    
    var proteinString: String {
        get {
            return protein > 0 ? String(protein) : ""
        }
        set (newValue) {
            protein = isNumber(newValue) ? Int(newValue) ?? 0 : 0
        }
    }
    
    var carbohydrateString: String {
        get {
            return carbohydrate > 0 ? String(carbohydrate) : ""
        }
        set (newValue) {
            carbohydrate = isNumber(newValue) ? Int(newValue) ?? 0 : 0
        }
    }
    
    var fiberString: String {
        get {
            return fiber > 0 ? String(fiber) : ""
        }
        set (newValue) {
            fiber = isNumber(newValue) ? Int(newValue) ?? 0 : 0
        }
    }
    
    var sodiumString: String {
        get {
            return sodium > 0 ? String(sodium) : ""
        }
        set (newValue) {
            sodium = isNumber(newValue) ? Int(newValue) ?? 0 : 0
        }
    }
    
    var cholesterolString: String {
        get {
            return cholesterol > 0 ? String(cholesterol) : ""
        }
        set (newValue) {
            cholesterol = isNumber(newValue) ? Int(newValue) ?? 0 : 0
        }
    }
    
    var displayServingSize: String {
        get {
            switch (servingSizeUnit) {
                case .each:
                    return "Each"
                case .g:
                    return "G"
                default:
                    return ""
                }
        }
    }
    
    var dataStore: FoodDataStore {
        get {
            return FoodDataStore(
                id: id,
                name: name,
                brand: brand,
                servingSizeUnit: displayServingSize,
                calories: calories,
                fat: fat,
                protein: protein,
                carbohydrate: carbohydrate,
                fiber: fiber,
                sodium: sodium,
                cholesterol: cholesterol
            )
        }
    }
    
    func loadFromDataStore(data: FoodDataStore) -> Void {
        id = data.id
        name = data.name
        brand = data.brand
        calories = data.calories
        fat = data.fat
        protein = data.protein
        carbohydrate = data.carbohydrate
        fiber = data.fiber
        sodium = data.sodium
        cholesterol = data.cholesterol
        
        switch (data.servingSizeUnit) {
            case "Each":
                servingSizeUnit = .each
            case "G":
                servingSizeUnit = .g
            default:
                servingSizeUnit = .other
        }
    }
}
