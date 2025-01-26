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
    @State private var showDeleteConfirmation: Bool = false
    @State private var showEditConfirmation: Bool = false

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

                    Button(action: {
                        showDeleteConfirmation = true
                    }) {
                        Text("Delete")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .alert(isPresented: $showDeleteConfirmation) {
                    Alert(
                        title: Text("Confirm Delete"),
                        message: Text("Workoutlogs based on this template are getting deleted."),
                        primaryButton: .default(Text("Delete"), action: deleteTemplate),
                        secondaryButton: .cancel()
                    )
                }
                .alert(isPresented: $showEditConfirmation) {
                    Alert(title: Text("Success"), message: Text("Template is updated"))
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
            showEditConfirmation = true
        } else {
            print("Failed to update template \(templateID)")
        }
    }

    private func deleteTemplate() {
        if TemplateManager.shared.deleteTemplateWithContent(id: templateID) {
            onDelete()
        }
    }
}

