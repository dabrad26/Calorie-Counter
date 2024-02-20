//
//  FoodApiData.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/19/24.
//

import Foundation

struct FoodApiData: Decodable {
    let foods: [FoodApiItem]
}

struct FoodApiItem: Decodable {
    let description: String?
    let brandName: String?
    let servingSizeUnit: String?
    let servingSize: Double?
    let foodNutrients: [FoodNutrient]?
}

struct FoodNutrient: Decodable {
    /**
     - Energy
     - Protein
     - Total lipid (fat)
     - Carbohydrate, by difference
     - Total Sugars
     - Fiber, total dietary
     - Sodium, Na
     - Cholesterol
     */
    let nutrientName: String?
    let value: Double?
}
