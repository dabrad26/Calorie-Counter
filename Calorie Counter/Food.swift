//
//  Food.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/16/24.
//

import Foundation
import SwiftUI

enum ServingSizeUnit {
    case g
    case each
    case liter
    case ml
    case ounce
    case other
}


struct FoodDataStore: Codable {
    var id: UUID
    var name: String = ""
    var brand: String = ""
    var servingSize: Int = 0
    var servingSizeUnit: String = ""
    var calories: Int = 0
    var fat: Int = 0
    var protein: Int = 0
    var sugar: Int = 0
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
    /** Servering size */
    var servingSize: Int = 1
    /** Serving size unit (from API) */
    var servingSizeUnit: ServingSizeUnit = ServingSizeUnit.g
    /** Calories (energy) in KCAL */
    @Published var calories: Int = 0
    /** Total Fat in G */
    var fat: Int = 0
    /** Total Protein in G */
    var protein: Int = 0
    /** Total Sugar in G */
    var sugar: Int = 0
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
    
    var displayName: String {
        get {
            var nameString = name
            
            if (brand != "") {
                nameString = "\(name) (\(brand))"
            }
            
            return nameString
        }
    }
    
    var displayServingInfo: String {
        get {
            return "\(servingSizeString) \(displayServingSizeUnit)"
        }
    }
    
    var displayList: some View {
        get {
            var stringParts: [String] = [displayServingInfo, "\(caloriesString) Kcal"];
            
            if (fatString != "" && stringParts.count < 5) {
                stringParts.append("\(fatString)G fat")
            }
            
            if (sugarString != "" && stringParts.count < 5) {
                stringParts.append("\(sugarString)G sugar")
            }
            
            if (proteinString != "" && stringParts.count < 5) {
                stringParts.append("\(proteinString)G protein")
            }
            
            if (fiberString != "" && stringParts.count < 5) {
                stringParts.append("\(fiberString)G fiber")
            }
            
            if (carbohydrateString != "" && stringParts.count < 5) {
                stringParts.append("\(carbohydrateString)G carbs")
            }

            return VStack {
                Text(displayName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(stringParts.joined(separator: ", "))
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    var servingSizeString: String {
        get {
            return servingSize > 0 ? String(servingSize) : ""
        }
        set (newValue) {
            servingSize = isNumber(newValue) ? Int(newValue) ?? 0 : 0
        }
    }
    
    var caloriesString: String {
        get {
            return calories > -1 ? String(calories) : ""
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
    
    var sugarString: String {
        get {
            return sugar > 0 ? String(sugar) : ""
        }
        set (newValue) {
            sugar = isNumber(newValue) ? Int(newValue) ?? 0 : 0
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
    
    var displayServingSizeUnit: String {
        get {
            switch (servingSizeUnit) {
            case .each:
                return "Item"
            case .g:
                return "G"
            case .liter:
                return "L"
            case .ml:
                return "ML"
            case .ounce:
                return "OZ"
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
                servingSize: servingSize,
                servingSizeUnit: displayServingSizeUnit,
                calories: calories,
                fat: fat,
                protein: protein,
                sugar: sugar,
                carbohydrate: carbohydrate,
                fiber: fiber,
                sodium: sodium,
                cholesterol: cholesterol
            )
        }
    }
    
    func clearData() -> Void {
        id = UUID()
        name = ""
        brand = ""
        calories = 0
        fat = 0
        protein = 0
        sugar = 0
        carbohydrate = 0
        fiber = 0
        sodium = 0
        cholesterol = 0
        servingSize = 1
        servingSizeUnit = ServingSizeUnit.g
    }
    
    func loadFromDataStore(data: FoodDataStore) -> Void {
        id = data.id
        name = data.name
        brand = data.brand
        calories = data.calories
        fat = data.fat
        protein = data.protein
        sugar = data.sugar
        carbohydrate = data.carbohydrate
        fiber = data.fiber
        sodium = data.sodium
        cholesterol = data.cholesterol
        servingSize = data.servingSize
        
        switch (data.servingSizeUnit) {
        case "Item":
            servingSizeUnit = .each
        case "G":
            servingSizeUnit = .g
        case "L":
            servingSizeUnit = .liter
        case "ML":
            servingSizeUnit = .ml
        case "OZ":
            servingSizeUnit = .ounce
        default:
            servingSizeUnit = .other
        }
    }
}
