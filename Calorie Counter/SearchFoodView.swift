//
//  SearchFoodView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/17/24.
//

import SwiftUI

class SearchResultsApiData: ObservableObject {
    @Published var foods: [Food] = []
}

struct SearchFoodView: View {
    @State var searchText: String = ""
    @State var createFoodItem: Bool = false
    @State var loadingApi: Bool = false
    @Binding var showSearchView: Bool
    @ObservedObject var foodLog: FoodLog
    @ObservedObject var userStore: UserStore
    @ObservedObject var apiData = SearchResultsApiData()
    
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
    
    private func makeApiCall() async throws -> [Food] {
        let filePath = Bundle.main.path(forResource: "secrets", ofType: "plist")
        var apiKey: String?
        
        if (filePath != nil) {
            let plist = NSDictionary(contentsOfFile: filePath!)
            apiKey = plist?.object(forKey: "API_KEY") as? String
        }
        
        let url = URL(string: "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=\(apiKey ?? "MISSING")&query=\(searchText)")!

        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(FoodApiData.self, from: data)
        
        return decoded.foods.map { item in
            var newFoodItem = Food()
            newFoodItem.name = item.description ?? ""
            newFoodItem.brand = item.brandName ?? ""
            newFoodItem.servingSize = Int(item.servingSize ?? 1)
            
            switch (item.servingSizeUnit) {
            case "g", "GRM":
                newFoodItem.servingSizeUnit = .g
                break
            case "ml", "MLT":
                newFoodItem.servingSizeUnit = .ml
                break
            default:
                newFoodItem.servingSizeUnit = .each
                break
            }
            
            item.foodNutrients?.forEach { nutrient in
                switch (nutrient.nutrientName) {
                case "Energy":
                    newFoodItem.calories = Int(nutrient.value ?? 1)
                    break
                case "Protein":
                    newFoodItem.protein = Int(nutrient.value ?? 0)
                    break
                case "Total lipid (fat)":
                    newFoodItem.fat = Int(nutrient.value ?? 0)
                    break
                case "Carbohydrate, by difference":
                    newFoodItem.carbohydrate = Int(nutrient.value ?? 0)
                    break
                case "Total Sugars":
                    newFoodItem.sugar = Int(nutrient.value ?? 0)
                    break
                case "Fiber, total dietary":
                    newFoodItem.fiber = Int(nutrient.value ?? 0)
                    break
                case "Sodium, Na":
                    newFoodItem.sodium = Int(nutrient.value ?? 0)
                    break
                case "Cholesterol":
                    newFoodItem.cholesterol = Int(nutrient.value ?? 0)
                    break
                default:
                    break
                }
            }
            
            
            return newFoodItem
        }
    }
    
    private func searchApi() -> Void {
        loadingApi = true
        
        Task {
            do {
                apiData.foods = try await makeApiCall()
                loadingApi = false
            } catch {
                print("Unable to get API items. Error data:")
                print(error)
                loadingApi = false
            }
        }
    }

    var SearchBox: some View {
        TextField("Search ...", text: $searchText)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                if (searchText != "") {
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 16)
                    }
                }
            }
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    SearchBox
                    if (searchText != "") {
                        Button(action: {
                            searchApi()
                        }, label: {
                            Text("Search")
                        })
                    }
                }
                .padding(.horizontal)
                List {
                    if (loadingApi) {
                        LoadingView()
                    }
                    ForEach(apiData.foods) { food in
                        getListButton(food)
                    }
                    ForEach(userStore.foods.filter { food in
                        let text = "\(food.name.lowercased()) \(food.brand.lowercased())"
                        
                        return searchText == "" || text.contains(searchText.lowercased())
                    }) { food in
                        getListButton(food)
                    }
                    Button("Create New Food") {
                        searchText = ""
                        apiData.foods = []
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
            .sheet(isPresented: $createFoodItem) {
                NewFoodView(showNewForm: $createFoodItem, userStore: userStore, food: nil)
            }
        }
    }
}

#Preview {
    SearchFoodView(showSearchView: .constant(true), userStore: UserStore(), foodLog: ObservedObject(initialValue: FoodLog()))
}
