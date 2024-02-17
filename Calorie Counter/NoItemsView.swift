//
//  NoItemsView.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/16/24.
//

import SwiftUI

struct NoItemsView: View {
    var body: some View {
        VStack {
            Text("No Items Exist")
                .font(.title)
            Text("Try Creating One")
                .font(.headline)
                .padding(.bottom, 24)
            Image("empty_graphic")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding(32)
    }
}

#Preview {
    NoItemsView()
}
