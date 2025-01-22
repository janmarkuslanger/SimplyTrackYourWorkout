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

                VStack(spacing: 12) {
                    NavigationLink(destination: ManageTemplatesView()) {
                        Text("Manage Templates")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    NavigationLink(destination: ManageWorkoutsView()) {
                        Text("Workout history")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }.padding()
                
            }
            .navigationTitle("Track Workout")
        }
    }

    private func loadTemplates() {
        templates = TemplateManager.shared.readTemplates()
    }
}
