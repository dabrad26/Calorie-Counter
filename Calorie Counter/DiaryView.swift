//
//  HistoryView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct DiaryView: View {
    @State private var showNewForm = false
    
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
    DiaryView()
}
