//
//  AccountDelete.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct AccountDelete: View {
    @ObservedObject var userStore: UserStore
    @State private var showConfirm: Bool = false
    @State private var resetSuccess: Bool = false
    
    var body: some View {
        VStack {
            if (resetSuccess) {
                Text("App has been reset!")
                    .font(.headline)
                    .padding(.bottom)
            } else {
                Text("Delete all data and reset the app")
                    .font(.headline)
                    .padding(.bottom)
                Text("This cannot be undone")
                    .font(.subheadline)
                    .padding(.bottom)
                Button(action: {
                    showConfirm = true
                }, label: {
                    Text("DELETE ACCOUNT")
                        .padding()
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                })
                .background(Theme.brandTertiary)
            }
        }
        .padding()
        .navigationTitle("Delete Account")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showConfirm, content: {
            Alert(title: Text("Are you sure you want to delete your account?"), primaryButton: .default(
                Text("No"),
                action: {
                    showConfirm = false
                }
            ),
                  secondaryButton: .destructive(
                    Text("Yes"),
                    action: {
                        userStore.clearData()
                        showConfirm = false
                        resetSuccess = true
                    }
                  ))
        })
    }
}

#Preview {
    AccountDelete(userStore: UserStore())
}
