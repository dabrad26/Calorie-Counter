//
//  AccountImport.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct AccountImport: View {
    @ObservedObject var userStore: UserStore
    @State var showImport: Bool = false
    @State var importSuccess: Bool = false
    @State var importFail: Bool = false
    
    private func readFile(file: URL) -> Void {
        do {
            let fileContent = try String(contentsOf: file)
            userStore.foods = []
            userStore.foodLogs = []
            userStore.initializeData(userData: fileContent)
            userStore.saveData()
            importSuccess = true
        } catch {
            print("AccountImport: could not read file: \(error.localizedDescription)")
            importFail = true
        }
    }
    
    var body: some View {
        VStack {
            if (importSuccess) {
                Text("Data has been imported!")
                    .font(.headline)
                    .padding(.bottom)
            } else if (importFail) {
                Text("Data could not be imported!")
                    .font(.headline)
                    .foregroundStyle(.red)
                    .padding(.bottom)
            } else {
                Text("Import JSON data")
                    .font(.headline)
                    .padding(.bottom)
                Text("Import data into this app. Any existing data will be deleted. This cannot be undone.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                Button(action: {
                    showImport = true
                }, label: {
                    Text("Import Data")
                        .padding()
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                })
                .background(Theme.brandPrimary)
            }
        }
        .padding()
        .navigationTitle("Import Data")
        .navigationBarTitleDisplayMode(.inline)
        .fileImporter(isPresented: $showImport, allowedContentTypes: [.text], allowsMultipleSelection: false) { result in
            switch (result) {
            case .success(let files):
                files.forEach { file in
                    let gotAccess = file.startAccessingSecurityScopedResource()
                    if (!gotAccess) {
                        print("AccountImport: no access to the file")
                        return
                    }
                    
                    readFile(file: file)
                    file.stopAccessingSecurityScopedResource()
                    
                }
            case .failure(let error):
                // handle error
                print(error)
            }
        }
    }
}

#Preview {
    AccountImport(userStore: UserStore())
}
