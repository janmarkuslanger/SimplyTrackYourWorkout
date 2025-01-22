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

                VStack(spacing: 12) {
                    NavigationLink(destination: EditTemplateExercisesView(templateID: templateID)) {
                        Text("Edit Exercises")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: saveTemplate) {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }

                    Button(action: deleteTemplate) {
                        Text("Delete")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
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

