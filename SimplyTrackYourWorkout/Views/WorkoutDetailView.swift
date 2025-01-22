//
//  WorkoutDetailView.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//


import SwiftUI

struct WorkoutDetailView: View {
    let workoutID: Int64
    let workoutDate: String
    let onDelete: () -> Void
    
    @State private var exercises: [(name: String, sets: [(reps: Int, weight: Int)])] = []

    var body: some View {
        VStack {
            Text("Workout Date: \(workoutDate)")
                .font(.headline)
                .padding()

            List {
                ForEach(exercises, id: \.name) { exercise in
                    Section(header: Text(exercise.name)) {
                        ForEach(0..<exercise.sets.count, id: \.self) { setIndex in
                            HStack {
                                Text("Set \(setIndex + 1)")
                                Spacer()
                                Text("Reps: \(exercise.sets[setIndex].reps)")
                                Spacer()
                                Text("Weight: \(exercise.sets[setIndex].weight) kg")
                            }
                        }
                    }
                }
            }
            .padding()
            
            Button(action: deleteWorkout) {
                Text("Delete")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
        }
        .navigationTitle("Workout Details")
        .onAppear(perform: loadWorkoutDetails)
    }
    
    private func deleteWorkout() {
        let exercises = WorkoutExerciseManager.shared.getWorkoutExercises(workoutID: workoutID)
        
        for exercise in exercises {
            WorkoutExerciseManager.shared.deleteWorkoutExercise(id: exercise.id)
        }
        
        if WorkoutManager.shared.deleteWorkout(id: workoutID) {
            onDelete()
        }
    }

    private func loadWorkoutDetails() {
        exercises = WorkoutExerciseManager.shared.getWorkoutExercises(workoutID: workoutID).map { exercise in
            let sets = WorkoutSetManager.shared.readWorkoutSets(exerciseID: exercise.id)
            return (name: exercise.name, sets: sets)
        }
    }
}
