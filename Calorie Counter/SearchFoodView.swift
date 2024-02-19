//
//  SearchFoodView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/17/24.
//

import SwiftUI

struct SearchFoodView: View {
    @State var searchText: String = ""
    @State var createFoodItem: Bool = false
    @Binding var showSearchView: Bool
    @ObservedObject var foodLog: FoodLog
    @ObservedObject var userStore: UserStore
    
    init(showSearchView: Binding<Bool>, userStore: UserStore, foodLog: ObservedObject<FoodLog>) {
        self._foodLog = foodLog
        self.userStore = userStore
        self._showSearchView = showSearchView
    }
    
    private func getListButton(_ item: Food) -> some View {
        return Button(action: {
            foodLog.food = item
            showSearchView = false
        }, label: {
            item.displayList
        })
        .foregroundColor(.primary)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(userStore.foods.filter { food in
                        let text = "\(food.name.lowercased()) \(food.brand.lowercased())"
                        
                        return searchText == "" || text.contains(searchText.lowercased())
                    }) { food in
                        getListButton(food)
                    }
                    Button("Create New Food") {
                        searchText = ""
                        createFoodItem = true
                    }
                }
            }
            .navigationTitle("Search for Food")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showSearchView = false
                    }
                    .fontWeight(.bold)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .sheet(isPresented: $createFoodItem) {
                NewFoodView(showNewForm: $createFoodItem, userStore: userStore, food: nil)
            }
        }
    }
}

#Preview {
    SearchFoodView(showSearchView: .constant(true), userStore: UserStore(), foodLog: ObservedObject(initialValue: FoodLog()))
}
