//
//  MyFoodView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct MyFoodView: View {
    @ObservedObject var userStore: UserStore
    @State private var showNewForm = false
    @ObservedObject private var editItem: Food = Food()
    
    init(userStore: UserStore) {
        self.userStore = userStore
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if (userStore.foods.count == 0) {
                    NoItemsView()
                } else {
                    List {
                        ForEach(userStore.foods) { food in
                            Button(action: {
                                editItem.loadFromDataStore(data: food.dataStore)
                                showNewForm = true
                            }, label: {
                                food.displayList
                            })
                            .foregroundColor(.primary)
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle("My Foods")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New Food") {
                        editItem.clearData()
                        showNewForm = true
                    }
                    .fontWeight(.bold)
                }
            }
            .sheet(isPresented: $showNewForm) {
                let editMode: Bool = editItem.name != ""
                
                NewFoodView(showNewForm: $showNewForm, userStore: userStore, editMode: editMode, food: editMode ? ObservedObject(initialValue: editItem) : nil)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        userStore.removeFoodItem(offsets: offsets)
    }
}

#Preview {
    MyFoodView(userStore: UserStore())
}
