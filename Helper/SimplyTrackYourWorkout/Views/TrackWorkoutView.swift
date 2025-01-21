//
//  TrackWorkoutView.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//

import SwiftUI

struct TrackWorkoutView: View {
    let templateID: Int64
    let templateName: String
    @State private var exercises: [(id: Int64, name: String, sets: [(reps: Int, weight: Int)])] = []
    @State private var workoutDate: Date = Date()

    var body: some View {
        VStack {
            DatePicker("Workout Date", selection: $workoutDate, displayedComponents: .date)
                .padding()

            List {
                ForEach(0..<exercises.count, id: \.self) { exerciseIndex in
                    Section(header: Text(exercises[exerciseIndex].name)) {
                        ForEach(0..<exercises[exerciseIndex].sets.count, id: \.self) { setIndex in
                            HStack {
                                Text("Set \(setIndex + 1)")
                                Spacer()
                                TextField("Reps", value: Binding(
                                    get: { exercises[exerciseIndex].sets[setIndex].reps },
                                    set: { exercises[exerciseIndex].sets[setIndex].reps = $0 }
                                ), formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .frame(width: 60)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                                TextField("Weight", value: Binding(
                                    get: { exercises[exerciseIndex].sets[setIndex].weight },
                                    set: { exercises[exerciseIndex].sets[setIndex].weight = $0 }
                                ), formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .frame(width: 60)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        Button(action: {
                            addSet(to: exerciseIndex)
                        }) {
                            Text("Add Set")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }

            Button(action: saveWorkout) {
                Text("Save Workout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }

            Spacer()
        }
        .navigationTitle("Track Workout")
        .onAppear(perform: loadExercises)
    }

    private func loadExercises() {
        let templateExercises = TemplateExerciseManager.shared.readTemplateExercises(templateID: templateID)
        exercises = templateExercises.map { exercise in
            (id: exercise.id, name: exercise.name, sets: Array(repeating: (reps: 0, weight: 0), count: exercise.sets))
        }
    }

    private func addSet(to exerciseIndex: Int) {
        exercises[exerciseIndex].sets.append((reps: 0, weight: 0))
    }

    private func saveWorkout() {
        guard let workoutID = WorkoutManager.shared.createWorkout(date: workoutDate, templateID: templateID) else {
            print("Failed to create workout.")
            return
        }

        for exercise in exercises {
            for set in exercise.sets {
                if WorkoutExerciseManager.shared.addWorkoutExercise(
                    workoutID: workoutID,
                    name: exercise.name,
                    reps: set.reps,
                    weight: set.weight
                ) == nil {
                    print("Failed to save exercise \(exercise.name).")
                }
            }
        }
        print("Workout saved successfully.")
    }

}
