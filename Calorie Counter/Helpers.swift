//
//  Helpers.swift
//  Calorie Counter
//
//  Created by David Bradshaw on 2/16/24.
//

import Foundation
import SwiftUI

func getNumberField(_ value: Binding<String>, _ label: String) -> some View {
    return HStack {
        Text(label)
        TextField("", text: value)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.trailing)
            .onKeyPress(phases: .down) { press in
                if (
                    press.key == KeyEquivalent.clear ||
                    press.key == KeyEquivalent.delete ||
                    press.key == KeyEquivalent.deleteForward ||
                    press.key == KeyEquivalent.upArrow ||
                    press.key == KeyEquivalent.downArrow ||
                    press.key == KeyEquivalent.leftArrow ||
                    press.key == KeyEquivalent.rightArrow ||
                    press.key == KeyEquivalent.home ||
                    press.key == KeyEquivalent.end ||
                    press.key == KeyEquivalent.tab ||
                    press.key == KeyEquivalent.pageUp ||
                    press.key == KeyEquivalent.pageDown ||
                    Int(press.characters) != nil
                ) {
                    return .ignored
                } else {
                    return .handled
                }
            }
    }
    
}
