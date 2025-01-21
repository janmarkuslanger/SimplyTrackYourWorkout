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
    let onDelete: () -> Void

    init(templateID: Int64, currentName: String, onSave: @escaping () -> Void, onDelete: @escaping () -> Void) {
        self.templateID = templateID
        self._templateName = State(initialValue: currentName)
        self.onSave = onSave
        self.onDelete = onDelete
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Template Name", text: $templateName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                NavigationLink(destination: EditTemplateExercisesView(templateID: templateID)) {
                    Text("Edit Exercises")
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
                .padding()

                Button(action: saveTemplate) {
                    Text("Save")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                Button(action: deleteTemplate) {
                    Text("Delete")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Spacer()
            }
            .navigationTitle("Edit Template")
            .padding()
        }
    }

    private func saveTemplate() {
        guard !templateName.isEmpty else { return }
        if TemplateManager.shared.updateTemplate(id: templateID, newName: templateName) {
            onSave()
        } else {
            print("Failed to update template \(templateID)")
        }
    }

    private func deleteTemplate() {
        if TemplateManager.shared.deleteTemplate(id: templateID) {
            onDelete()
        }
    }
}

