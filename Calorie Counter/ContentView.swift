//
//  ContentView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "flame.fill")
                }
            DiaryView()
                .tabItem {
                    Label("Diary", systemImage: "calendar")
                }
            MyFoodView()
                .tabItem {
                    Label("My Foods", systemImage: "fork.knife")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
