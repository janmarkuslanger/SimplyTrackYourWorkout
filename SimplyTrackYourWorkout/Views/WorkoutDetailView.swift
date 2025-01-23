import SwiftUI

struct WorkoutDetailView: View {
    let workoutID: Int64
    let workoutDate: String
    let onDelete: () -> Void

    @State private var exercises: [(exerciseID: Int64, sets: [(reps: Int, weight: Int)])] = []

    var body: some View {
        VStack {
            Text("Workout Date: \(workoutDate)")
                .font(.headline)
                .padding()

            List {
                ForEach(exercises, id: \..exerciseID) { exercise in
                    if let exerciseDetails = ExerciseConstants.exercises[Int64(exercise.exerciseID)] {
                        Section(header: Text(exerciseDetails.name)) {
                            ForEach(0..<exercise.sets.count, id: \..self) { setIndex in
                                HStack {
                                    Text("Set \(setIndex + 1)")
                                    Spacer()
                                    Text("Reps: \(exercise.sets[setIndex].reps)")
                                    Spacer()
                                    Text("Weight: \(exercise.sets[setIndex].weight) kg")
                                }
                            }
                        }
                    } else {
                        Section(header: Text("Unknown Exercise")) {
                            ForEach(0..<exercise.sets.count, id: \..self) { setIndex in
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
            let workoutExercises = WorkoutExerciseManager.shared.getWorkoutExercises(workoutID: workoutID)

            exercises = workoutExercises.compactMap { exercise in
                let sets = WorkoutSetManager.shared.readWorkoutSets(exerciseID: exercise.id)
                return (exerciseID: exercise.exerciseID, sets: sets)
            }
        }
}
