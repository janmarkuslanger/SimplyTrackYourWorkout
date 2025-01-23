import SwiftUI

struct TrackWorkoutView: View {
    let templateID: Int64
    let templateName: String
    @State private var exercises: [(id: Int64, exerciseID: Int64, sets: [(reps: Int, weight: Int)])] = []
    @State private var workoutDate: Date = Date()
    @State private var showSaveConfirmation: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            DatePicker("Workout Date", selection: $workoutDate, displayedComponents: .date)
                .padding()

            List {
                ForEach(0..<exercises.count, id: \..self) { exerciseIndex in
                    let lastSetValues = loadLastWorkoutValues(for: exercises[exerciseIndex].exerciseID)

                    Section(header: Text(getExerciseName(by: exercises[exerciseIndex].exerciseID))) {
                        ForEach(0..<exercises[exerciseIndex].sets.count, id: \..self) { setIndex in
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
                                    .buttonStyle(BorderlessButtonStyle())
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
            .simultaneousGesture(TapGesture().onEnded {
                hideKeyboard()
            })

            Button(action: {
                showSaveConfirmation = true
            }) {
                Text("Save Workout")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
            .alert(isPresented: $showSaveConfirmation) {
                Alert(
                    title: Text("Confirm Save"),
                    message: Text("Are you sure you want to save and end this workout?"),
                    primaryButton: .default(Text("Save"), action: saveWorkout),
                    secondaryButton: .cancel()
                )
            }

            Spacer()
        }
        .navigationTitle("Track Workout")
        .onAppear(perform: loadExercises)
    }

    private func getExerciseName(by exerciseID: Int64) -> String {
        return ExerciseConstants.exercises[Int64(exerciseID)]?.name ?? "Unknown Exercise"
    }

    private func loadLastWorkoutValues(for exerciseID: Int64) -> [(reps: Int, weight: Int)] {
        return WorkoutSetManager.shared.getLastWorkoutSetsForExercise(exerciseID: exerciseID)
    }

    private func loadExercises() {
        exercises = TemplateExerciseManager.shared.readTemplateExercises(templateID: templateID).map { exercise in
            (id: exercise.id, exerciseID: exercise.exerciseID, sets: Array(repeating: (reps: 0, weight: 0), count: exercise.sets))
        }
    }

    private func deleteSet(at setIndex: Int, for exerciseIndex: Int) {
        guard exercises[exerciseIndex].sets.indices.contains(setIndex) else { return }
        exercises[exerciseIndex].sets.remove(at: setIndex)
        print("Set \(setIndex + 1) deleted for exercise \(exercises[exerciseIndex].exerciseID)")
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
            guard let workoutExerciseID = WorkoutExerciseManager.shared.addWorkoutExercise(
                workoutID: workoutID,
                templateExerciseID: exercise.id
            ) else {
                print("Failed to add workout exercise with templateExerciseID: \(exercise.id)")
                continue
            }

            for set in exercise.sets {
                if WorkoutSetManager.shared.createWorkoutSet(
                    exerciseID: workoutExerciseID,
                    reps: set.reps,
                    weight: set.weight
                ) == nil {
                    print("Failed to save set for exerciseID: \(exercise.exerciseID)")
                }
            }
        }

        print("Workout saved successfully.")
        presentationMode.wrappedValue.dismiss()
    }
}
