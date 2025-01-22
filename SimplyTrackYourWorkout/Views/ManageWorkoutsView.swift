//
//  ManageWorkoutsView.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//
import SwiftUI

struct ManageWorkoutsView: View {
    @State private var workouts: [(id: Int64, date: String, templateName: String)] = []

    var body: some View {
        NavigationView {
            List(workouts, id: \.id) { workout in
                NavigationLink(
                    destination: WorkoutDetailView(
                        workoutID: workout.id,
                        workoutDate: workout.date
                    )
                ) {
                    HStack {
                        Text(workout.date)
                            .font(.headline)
                        Spacer()
                        Text(workout.templateName)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Manage Workouts")
            .onAppear(perform: loadWorkouts)
        }
    }

    private func loadWorkouts() {
        workouts = WorkoutManager.shared.readWorkouts().map { workout in
            let templateName = TemplateManager.shared.getTemplateName(by: workout.templateID) ?? "Unknown"
            return (id: workout.id, date: workout.date, templateName: templateName)
        }
    }
}
