//
//  LogFoodView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct LogFoodView: View {
    @Binding var showNewForm: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Log Food Item")
            }
            .navigationTitle("Log Food")
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
                        // TODO: Save data
                        showNewForm = false
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    LogFoodView(showNewForm: .constant(true))
}
