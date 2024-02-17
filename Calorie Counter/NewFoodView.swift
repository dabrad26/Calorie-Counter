//
//  NewFoodView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct NewFoodView: View {
    @Binding var showNewForm: Bool
    @ObservedObject var food: Food
    @ObservedObject var userStore: UserStore
    private var editMode: Bool

    init(showNewForm: Binding<Bool>, userStore: UserStore, editMode: Bool = false, food: ObservedObject<Food> = ObservedObject(initialValue: Food())) {
        self._food = food
        self.userStore = userStore
        self._showNewForm = showNewForm
        self.editMode = editMode
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Details")) {
                        TextField("Name", text: $food.name)
                        TextField("Brand", text: $food.brand)
                    }
                    Section(header: Text("Serving Size")) {
                        Picker("Unit", selection: $food.servingSizeUnit) {
                            Text("Gram").tag(ServingSizeUnit.g)
                            Text("Each").tag(ServingSizeUnit.each)
                            Text("Other").tag(ServingSizeUnit.other)
                        }
                    }
                    Section(header: Text("Nutrition")) {
                        getNumberField($food.caloriesString, "Calories (Kcal)")
                        getNumberField($food.fatString, "Fat (G)")
                        getNumberField($food.proteinString, "Protein (G)")
                        getNumberField($food.carbohydrateString, "Carbohydrate (G)")
                        getNumberField($food.fiberString, "Fiber (G)")
                        getNumberField($food.sodiumString, "Sodium (MG)")
                        getNumberField($food.cholesterolString, "Cholesterol (MG)")
                    }
                }
            }
            .navigationTitle("New Food")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showNewForm = false
                    }
                    .fontWeight(.bold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if (editMode) {
                            userStore.saveData()
                        } else {
                            userStore.addFoodItem(item: food)
                        }

                        showNewForm = false
                    }
                    .fontWeight(.bold)
                    .disabled(!(food.name != "" && food.calories > 0))
                }
            }
        }
    }
}

#Preview {
    NewFoodView(showNewForm: .constant(true), userStore: UserStore())
}
