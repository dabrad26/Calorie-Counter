//
//  TodayView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct TodayView: View {
    @ObservedObject var userStore: UserStore
    @State private var showNewForm = false
    @ObservedObject private var editItem: FoodLog = FoodLog()
    
    init(userStore: UserStore) {
        self.userStore = userStore
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Today View")
            }
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log Food") {
                        editItem.clearData()
                        showNewForm = true
                    }
                    .fontWeight(.bold)
                }
            }
            .sheet(isPresented: $showNewForm) {
                let editMode: Bool = editItem.food.name != ""
                
                LogFoodView(showNewForm: $showNewForm, userStore: userStore, editMode: editMode, showDate: true, foodLog: editMode ? ObservedObject(initialValue: editItem) : nil)
            }
        }
    }
}

#Preview {
    TodayView(userStore: UserStore())
}
