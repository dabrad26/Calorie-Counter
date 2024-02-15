//
//  NewFoodView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct NewFoodView: View {
    @Binding var showNewForm: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("New Food Item")
            }
            .navigationTitle("New Food")
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
    NewFoodView(showNewForm: .constant(true))
}
