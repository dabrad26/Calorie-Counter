//
//  AccountAbout.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/14/24.
//

import SwiftUI

struct AccountAbout: View {
    var body: some View {
        List {
            Section(header: Text("Developer")) {
                HStack {
                    Image(systemName: "person.fill")
                    Text("David Bradshaw")
                }
                Button(action: {
                    if let url = URL(string: "https://davidbradshaw.us") {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    HStack {
                        Image(systemName: "safari")
                        Text(verbatim: "https://davidbradshaw.us")
                        Spacer()
                        Image(systemName: "link")
                    }
                })
                .foregroundColor(.primary)
                Button(action: {
                    if let url = URL(string: "https://linkedin.com/in/davidbradshawus") {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    HStack {
                        Image(systemName: "safari")
                        Text(verbatim: "LinkedIn")
                        Spacer()
                        Image(systemName: "link")
                    }
                })
                .foregroundColor(.primary)
                Button(action: {
                    if let url = URL(string: "https://github.com/dabrad26") {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    HStack {
                        Image(systemName: "safari")
                        Text(verbatim: "GitHub")
                        Spacer()
                        Image(systemName: "link")
                    }
                })
                .foregroundColor(.primary)
            }
            Section(header: Text("Project")) {
                HStack {
                    Image(systemName: "iphone.gen3")
                    Text("Calorie Counter for iOS")
                }
                Button(action: {
                    if let url = URL(string: "https://github.com/dabrad26/Calorie-Counter") {
                        UIApplication.shared.open(url)
                    }
                }, label: {
                    HStack {
                        Image(systemName: "safari")
                        Text(verbatim: "GitHub")
                        Spacer()
                        Image(systemName: "link")
                    }
                })
                .foregroundColor(.primary)
            }
            Section(header: Text("Class")) {
                HStack {
                    Image(systemName: "building.columns")
                    Text("UC San Diego Extended Studies")
                }
                HStack {
                    Image(systemName: "graduationcap.fill")
                    Text("iOS App Productions (CSE-41249)")
                }
                HStack {
                    Image(systemName: "calendar")
                    Text("Winter 2024")
                }
            }
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AccountAbout()
}
