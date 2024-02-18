//
//  HistoryView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct DiaryView: View {
    @ObservedObject var userStore: UserStore
    @State private var showNewForm = false
    
    init(userStore: UserStore) {
        self.userStore = userStore
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if (userStore.foodLogs.count == 0) {
                    NoItemsView()
                } else {
                    List {
                        Section() {
                            ForEach(userStore.foodLogs) { foodLog in
                                foodLog.displayList
                            }
                            .onDelete(perform: { indexSet in
                                indexSet.forEach { index in
                                    let foundItem: FoodLog? = userStore.foodLogs[index]
                                    
                                    if (foundItem != nil) {
                                        userStore.removeFoodLogItem(item: foundItem!)
                                    }
                                }
                            })
                        }
                    }
                }
            }
            .navigationTitle("Diary")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Log Food") {
                        showNewForm = true
                    }
                    .fontWeight(.bold)
                }
            }
            .sheet(isPresented: $showNewForm) {
                LogFoodView(showNewForm: $showNewForm, userStore: userStore, showDate: true)
            }
        }
    }
}

#Preview {
    DiaryView(userStore: UserStore())
}
