//
//  ManageTemplatesView.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//
import SwiftUI

struct ManageTemplatesView: View {
    @State private var templates: [(id: Int64, name: String)] = []
    @State private var newTemplateName: String = ""
    @State private var showingEditView: Bool = false
    @State private var selectedTemplate: (id: Int64, name: String)? = nil

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(templates, id: \.id) { template in
                        HStack {
                            Text(template.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .contentShape(Rectangle())
                                .onTapGesture {}

                            Button(action: {
                                selectedTemplate = template
                                showingEditView = true
                            }) {
                                Text("Edit")
                                    .foregroundColor(.blue)
                            }

                        }
                    }
                }

                HStack {
                    TextField("New Template Name", text: $newTemplateName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: addTemplate) {
                        Text("Add")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationTitle("Manage Templates")
            .onAppear(perform: loadTemplates)
            .sheet(isPresented: $showingEditView) {
                if let selectedTemplate = selectedTemplate {
                    EditTemplateView(
                        templateID: selectedTemplate.id,
                        currentName: selectedTemplate.name,
                        onSave: {
                            loadTemplates()
                            showingEditView = false
                        },
                        onDelete: {
                            loadTemplates()
                            showingEditView = false
                        }
                    )
                }
            }
        }
    }

    private func loadTemplates() {
        templates = TemplateManager.shared.readTemplates()
    }

    private func addTemplate() {
        guard !newTemplateName.isEmpty else {
            print("Template name is empty. Cannot add template.")
            return
        }
        
        if let rowID = TemplateManager.shared.createTemplate(name: newTemplateName) {
            print("Template added with ID: \(rowID)")
            newTemplateName = ""
            loadTemplates()
        } else {
            print("Failed to add template. Please check the database.")
        }
    }
}
