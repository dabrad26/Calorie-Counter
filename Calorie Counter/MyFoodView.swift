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
                            food.displayList
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationTitle("My Foods")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New Food") {
                        showNewForm = true
                    }
                    .fontWeight(.bold)
                }
            }
            .sheet(isPresented: $showNewForm) {
                NewFoodView(showNewForm: $showNewForm, userStore: userStore)
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
