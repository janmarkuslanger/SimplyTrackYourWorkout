import SwiftUI

struct HomePageView: View {
    @State private var templates: [(id: Int64, name: String)] = []

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(templates, id: \.id) { template in
                        NavigationLink(destination: TrackWorkoutView(templateID: template.id, templateName: template.name)) {
                            Text(template.name)
                        }
                    }
                }
                .onAppear(perform: loadTemplates)
            }
            .navigationTitle("Templates")
        }
    }

    private func loadTemplates() {
        templates = TemplateManager.shared.readTemplates()
    }
}
