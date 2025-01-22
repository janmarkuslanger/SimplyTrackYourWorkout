import SwiftUI

struct TrackWorkoutView: View {
    let templateID: Int64
    let templateName: String
    @State private var exercises: [(id: Int64, name: String, sets: [(reps: Int, weight: Int)])] = []
    @State private var workoutDate: Date = Date()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            DatePicker("Workout Date", selection: $workoutDate, displayedComponents: .date)
                .padding()

            List {
                ForEach(0..<exercises.count, id: \.self) { exerciseIndex in
                    let lastSetValues = loadLastWorkoutValues(for: exercises[exerciseIndex].id)
                    
                    Section(header: Text(exercises[exerciseIndex].name)) {
                        ForEach(0..<exercises[exerciseIndex].sets.count, id: \.self) { setIndex in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Set \(setIndex + 1)")
                                    Spacer()
                                    Button(action: {
                                        deleteSet(at: setIndex, for: exerciseIndex)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Reps (Last: \(setIndex < lastSetValues.count ? lastSetValues[setIndex].reps : 0))")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        TextField("Enter reps", value: Binding(
                                            get: { exercises[exerciseIndex].sets[setIndex].reps },
                                            set: { exercises[exerciseIndex].sets[setIndex].reps = $0 }
                                        ), formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                        .frame(width: 60)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    }

                                    Spacer()

                                    VStack(alignment: .leading) {
                                        Text("Weight (Last: \(setIndex < lastSetValues.count ? lastSetValues[setIndex].weight : 0) kg)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        TextField("Enter weight", value: Binding(
                                            get: { exercises[exerciseIndex].sets[setIndex].weight },
                                            set: { exercises[exerciseIndex].sets[setIndex].weight = $0 }
                                        ), formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                        .frame(width: 60)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    }
                                }
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
    
    private func loadLastWorkoutValues(for exerciseID: Int64) -> [(reps: Int, weight: Int)] {
        return WorkoutSetManager.shared.getLastWorkoutSetsForExercise(exerciseID: exerciseID)
    }


    private func loadExercises() {
        exercises = TemplateExerciseManager.shared.readTemplateExercises(templateID: templateID).map { exercise in
            (id: exercise.id, name: exercise.name, sets: Array(repeating: (reps: 0, weight: 0), count: exercise.sets))
        }
    }
    
    private func deleteSet(at setIndex: Int, for exerciseIndex: Int) {
        guard exercises[exerciseIndex].sets.indices.contains(setIndex) else { return }
        exercises[exerciseIndex].sets.remove(at: setIndex)
        print("Set \(setIndex + 1) deleted for exercise \(exercises[exerciseIndex].name)")
    }


    private func addSet(to exerciseIndex: Int) {
        exercises[exerciseIndex].sets.append((reps: 0, weight: 0))
    }

    private func saveWorkout() {
        let formattedDate = DateHelper.shared.string(from: workoutDate)

        guard let workoutID = WorkoutManager.shared.createWorkout(date: formattedDate, templateID: templateID) else {
            print("Failed to create workout.")
            return
        }

        for exercise in exercises {
            guard let exerciseID = WorkoutExerciseManager.shared.addWorkoutExercise(
                workoutID: workoutID,
                templateExerciseID: exercise.id
            ) else {
                print("Failed to add exercise \(exercise.name).")
                continue
            }

            for set in exercise.sets {
                if WorkoutSetManager.shared.createWorkoutSet(
                    exerciseID: exerciseID,
                    reps: set.reps,
                    weight: set.weight
                ) == nil {
                    print("Failed to save set for exercise \(exercise.name).")
                }
            }
        }
        print("Workout saved successfully.")
        presentationMode.wrappedValue.dismiss()
    }
}
