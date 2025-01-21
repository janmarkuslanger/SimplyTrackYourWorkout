//
//  EditTemplateExercisesView.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//
import SwiftUI

struct EditTemplateExercisesView: View {
    let templateID: Int64
    @State private var exercises: [(id: Int64, name: String, sets: Int, sortIndex: Int)] = []
    @State private var selectedExercise: String = ExerciseConstants.exercises.first?.name ?? ""
    @State private var sets: String = ""

    var body: some View {
        VStack {
            List {
                ForEach(exercises, id: \.id) { exercise in
                    HStack {
                        Text("\(exercise.name) - \(exercise.sets) sets")
                        Spacer()
                        Button(action: {
                            deleteExercise(exercise.id)
                        }) {
                            Text("Delete")
                                .foregroundColor(.red)
                        }
                    }
                }
                .onMove(perform: moveExercise)
            }
            .toolbar{
                EditButton()
            }

            Picker("Exercise", selection: $selectedExercise) {
                ForEach(ExerciseConstants.exercises, id: \.name) { exercise in
                    Text("\(exercise.name) (\(exercise.focus))").tag(exercise.name)
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
    }

    private func loadExercises() {
        exercises = TemplateExerciseManager.shared.readTemplateExercises(templateID: templateID)
    }

    private func addExercise() {
        guard !selectedExercise.isEmpty, let setsValue = Int(sets), setsValue > 0 else {
            print("Invalid input")
            return
        }

        let newSortIndex = (exercises.last?.sortIndex ?? -1) + 1
        if let _ = TemplateExerciseManager.shared.createTemplateExercise(
            templateID: templateID,
            name: selectedExercise,
            sets: setsValue,
            sortIndex: newSortIndex
        ) {
            sets = ""
            loadExercises()
        } else {
            print("Failed to add exercise")
        }
    }

    private func deleteExercise(_ id: Int64) {
        if TemplateExerciseManager.shared.deleteTemplateExercise(id: id) {
            loadExercises()
        } else {
            print("Failed to delete exercise")
        }
    }

    private func moveExercise(from source: IndexSet, to destination: Int) {
        exercises.move(fromOffsets: source, toOffset: destination)

        for (index, exercise) in exercises.enumerated() {
            if exercise.sortIndex != index {
                TemplateExerciseManager.shared.updateSortIndex(exerciseID: exercise.id, newSortIndex: index)
            }
        }

        exercises = exercises.enumerated().map { (index, exercise) in
            var updatedExercise = exercise
            updatedExercise.sortIndex = index
            return updatedExercise
        }
    }

}
