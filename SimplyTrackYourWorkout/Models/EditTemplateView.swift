//
//  EditTemplateView.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//
import SwiftUI

struct EditTemplateView: View {
    let templateID: Int64
    @State private var templateName: String
    let onSave: () -> Void

    init(templateID: Int64, currentName: String, onSave: @escaping () -> Void) {
        self.templateID = templateID
        self._templateName = State(initialValue: currentName)
        self.onSave = onSave
    }

    var body: some View {
        VStack {
            TextField("Template Name", text: $templateName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: saveTemplate) {
                Text("Save")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            Spacer()
        }
        .navigationTitle("Edit Template")
        .padding()
    }

    private func saveTemplate() {
        guard !templateName.isEmpty else { return }
        if TemplateManager.shared.updateTemplate(id: templateID, newName: templateName) {
            onSave()
        } else {
            print("Failed to update template \(templateID)")
        }
    }
}


