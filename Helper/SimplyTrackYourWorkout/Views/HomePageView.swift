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

                NavigationLink(destination: ManageTemplatesView()) {
                    Text("Manage Templates")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                }
            }
            .navigationTitle("Track Workout")
        }
    }

    private func loadTemplates() {
        templates = TemplateManager.shared.readTemplates()
    }
}
