import SwiftUI

struct ManageTemplatesView: View {
    @State private var templates: [String] = []
    @State private var newTemplateName: String = ""

    var body: some View {
        NavigationView {
            VStack {
                List(templates, id: \.self) { template in
                    Text(template)
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
        guard !newTemplateName.isEmpty else { return }
        if let _ = TemplateManager.shared.createTemplate(name: newTemplateName) {
            newTemplateName = ""
            loadTemplates()
        }
    }
}
