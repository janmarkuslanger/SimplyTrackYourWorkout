import SwiftUI

struct EditTemplateExercisesView: View {
    let templateID: Int64
    @State private var exercises: [(id: Int64, exerciseID: Int64, sets: Int, sortIndex: Int)] = []
    @State private var selectedExerciseID: Int64 = ExerciseConstants.exercises.first?.key ?? 0
    @State private var sets: String = ""

    var body: some View {
        VStack {
            List {
                ForEach(exercises, id: \..id) { exercise in
                    HStack {
                        if let exerciseDetails = ExerciseConstants.exercises[Int64(exercise.exerciseID)] {
                            Text("\(exerciseDetails.name) - \(exercise.sets) sets")
                        } else {
                            Text("Unknown Exercise - \(exercise.sets) sets")
                        }
                        Spacer()
                        Button(action: {
                            deleteExercise(exercise.id)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                .onMove(perform: moveExercise)
            }
            .toolbar {
                EditButton()
            }

            Picker("Exercise", selection: $selectedExerciseID) {
                ForEach(ExerciseConstants.exercises.keys.sorted(), id: \..self) { id in
                    if let exercise = ExerciseConstants.exercises[id] {
                        Text("\(exercise.name) (\(exercise.focus))").tag(id)
                    }
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding()

            TextField("Sets", text: $sets)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: addExercise) {
                Text("Add Exercise")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Spacer()
        }
        .navigationTitle("Edit Exercises")
        .onAppear(perform: loadExercises)
        .simultaneousGesture(TapGesture().onEnded {
            hideKeyboard()
        })
    }

    private func loadExercises() {
        exercises = TemplateExerciseManager.shared.readTemplateExercises(templateID: templateID)
            .sorted(by: { $0.sortIndex < $1.sortIndex })
    }

    private func addExercise() {
        guard selectedExerciseID > 0, let setsValue = Int(sets), setsValue > 0 else {
            return
        }

        let newSortIndex = (exercises.last?.sortIndex ?? -1) + 1
        if let _ = TemplateExerciseManager.shared.createTemplateExercise(
            templateID: templateID,
            exerciseID: selectedExerciseID,
            sets: setsValue,
            sortIndex: newSortIndex
        ) {
            sets = ""
            loadExercises()
        }
    }

    private func deleteExercise(_ id: Int64) {
        if TemplateExerciseManager.shared.deleteTemplateExercise(id: id) {
            loadExercises()
        }
    }

    private func moveExercise(from source: IndexSet, to destination: Int) {
        exercises.move(fromOffsets: source, toOffset: destination)

        for (index, exercise) in exercises.enumerated() {
            if TemplateExerciseManager.shared.updateSortIndex(exerciseID: exercise.id, newSortIndex: index) {
                exercises[index].sortIndex = index
            }
        }

        loadExercises()
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
