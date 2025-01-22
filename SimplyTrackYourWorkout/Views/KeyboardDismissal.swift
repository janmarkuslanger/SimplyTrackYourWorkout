//
//  KeyboardDismissal.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 22.01.25.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
