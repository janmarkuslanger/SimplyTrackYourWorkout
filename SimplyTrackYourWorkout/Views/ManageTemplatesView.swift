import SwiftUI

struct ManageTemplatesView: View {
    @State private var templates: [(id: Int64, name: String)] = []
    @State private var newTemplateName: String = ""

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(templates, id: \.id) { template in
                        NavigationLink(
                            destination: EditTemplateView(
                                templateID: template.id,
                                currentName: template.name,
                                onSave: {
                                    loadTemplates()
                                },
                                onDelete: {
                                    loadTemplates()
                                }
                            )
                        ) {
                            HStack {
                                Text(template.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
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
