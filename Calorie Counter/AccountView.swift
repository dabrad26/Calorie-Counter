//
//  AccountView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct AccountView: View {
    @ObservedObject var userStore: UserStore
    
    init(userStore: UserStore) {
        self.userStore = userStore
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Settings")) {
                    getNumberField($userStore.dailyCalories, "Daily Calories")
                        .onChange(of: userStore.dailyCalories) {
                            if (isNumber(userStore.dailyCalories)) {
                                userStore.saveData()
                            }
                        }
                }
                Section(header: Text("General")) {
                    NavigationLink(destination: AccountAbout()) {
                        HStack {
                            Image(systemName: "info.circle")
                            Text("About")
                        }
                    }
                }
                Section(header: Text("Data")) {
                    NavigationLink(destination: AccountImport(userStore: userStore)) {
                        HStack {
                            Image(systemName: "arrow.up.circle")
                            Text("Import Data")
                        }
                    }
                    NavigationLink(destination: AccountExport(userStore: userStore)) {
                        HStack {
                            Image(systemName: "arrow.down.circle")
                            Text("Export Data")
                        }
                    }
                }
                Section(header: Text("Account")) {
                    NavigationLink(destination: AccountDelete(userStore: userStore)) {
                        HStack {
                            Image(systemName: "xmark.circle")
                            Text("Delete Account")
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Account")
        }
        .accentColor(Theme.brandPrimary)
    }
}

#Preview {
    AccountView(userStore: UserStore())
}
