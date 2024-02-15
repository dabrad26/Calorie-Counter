//
//  AccountView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("GENERAL")) {
                    NavigationLink(destination: AccountAbout()) {
                        HStack {
                            Image(systemName: "info.circle")
                            Text("About")
                        }
                    }
                }
                Section(header: Text("DATA")) {
                    NavigationLink(destination: AccountImport()) {
                        HStack {
                            Image(systemName: "arrow.up.circle")
                            Text("Import Data")
                        }
                    }
                    NavigationLink(destination: AccountExport()) {
                        HStack {
                            Image(systemName: "arrow.down.circle")
                            Text("Export Data")
                        }
                    }
                }
                Section(header: Text("ACCOUNT")) {
                    NavigationLink(destination: AccountDelete()) {
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
    }
}

#Preview {
    AccountView()
}
