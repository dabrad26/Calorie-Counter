//
//  TodayView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct TodayView: View {
    @State private var showNewForm = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Today View")
            }
            .navigationTitle("Today")
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
    TodayView()
}
