//
//  MyFoodView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct MyFoodView: View {
    @State private var showNewForm = false;
    var body: some View {
        NavigationStack {
            VStack {
                Text("My Foods View")
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
                NewFoodView(showNewForm: $showNewForm)
            }
        }
    }
}

#Preview {
    MyFoodView()
}
