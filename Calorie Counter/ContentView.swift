//
//  ContentView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "figure.walk.circle.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Calorie Counter!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
