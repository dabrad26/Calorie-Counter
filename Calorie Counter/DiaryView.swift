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
                Text("Diary View")
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
                LogFoodView(showNewForm: $showNewForm)
            }
        }
    }
}

#Preview {
    DiaryView(userStore: UserStore())
}
