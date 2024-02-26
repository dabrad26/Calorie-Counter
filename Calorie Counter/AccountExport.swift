//
//  AccountExport.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct AccountExport: View {
    @ObservedObject var userStore: UserStore
    
    var body: some View {
        VStack {
            Text("Export data as JSON")
                .font(.headline)
                .padding(.bottom)
            Text("Save or share this file and you can import into this app or another device.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            ShareLink(item: userStore.lastStoredJson, preview: SharePreview("Calorie Counter Export Data")) {
                Text("Export Data")
                    .padding()
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .background(Theme.brandPrimary)
            }
        }
        .padding()
        .navigationTitle("Export Data")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AccountExport(userStore: UserStore())
}
