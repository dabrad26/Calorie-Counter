//
//  ContentView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/7/24.
//

import SwiftUI

struct ContentView: View {
    let userStore = UserStore()
    
    var body: some View {
        TabView {
            TodayView(userStore: userStore)
                .tabItem {
                    Label("Today", systemImage: "flame.fill")
                }
            DiaryView(userStore: userStore)
                .tabItem {
                    Label("Diary", systemImage: "calendar")
                }
            MyFoodView(userStore: userStore)
                .tabItem {
                    Label("My Foods", systemImage: "fork.knife")
                }
            AccountView(userStore: userStore)
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
        }
        .tint(Theme.brandPrimary)
    }
}

#Preview {
    ContentView()
}
