//
//  WorkoutExerciseManager.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//
import SQLite

class WorkoutExerciseManager {
    static let shared = WorkoutExerciseManager()

    private let db: Connection?

    private let workoutExercises = Table("workout_exercises")
    private let workoutExerciseID = Expression<Int64>("id")
    private let workoutExerciseWorkoutID = Expression<Int64>("workout_id")
    private let workoutExerciseName = Expression<String>("name")
    private let workoutExerciseSets = Expression<Int>("sets")
    private let workoutExerciseReps = Expression<Int>("reps")
    private let workoutExerciseWeight = Expression<Int>("weight")

    private init() {
        db = DatabaseManager.shared.getConnection()
    }

    func createWorkoutExercise(workoutID: Int64, name: String, sets: Int, reps: Int, weight: Int) -> Int64? {
        do {
            let insert = workoutExercises.insert(
                workoutExerciseWorkoutID <- workoutID,
                workoutExerciseName <- name,
                workoutExerciseSets <- sets,
                workoutExerciseReps <- reps,
                workoutExerciseWeight <- weight
            )
            let rowID = try db?.run(insert)
            return rowID
        } catch {
            print("Error creating workout exercise: \(error)")
            return nil
        }
    }

    func readWorkoutExercises(workoutID: Int64) -> [(name: String, sets: Int, reps: Int, weight: Int)] {
        var exercises: [(name: String, sets: Int, reps: Int, weight: Int)] = []
        do {
            if let db = db {
                let query = workoutExercises.filter(workoutExerciseWorkoutID == workoutID)
                for exercise in try db.prepare(query) {
                    let name = exercise[workoutExerciseName]
                    let sets = exercise[workoutExerciseSets]
                    let reps = exercise[workoutExerciseReps]
                    let weight = exercise[workoutExerciseWeight]
                    exercises.append((name, sets, reps, weight))
                }
            }
        } catch {
            print("Error reading workout exercises: \(error)")
        }
        return exercises
    }

    func updateWorkoutExercise(id: Int64, newName: String, newSets: Int, newReps: Int, newWeight: Int) -> Bool {
        do {
            let exercise = workoutExercises.filter(workoutExerciseID == id)
            if try db?.run(exercise.update(
                workoutExerciseName <- newName,
                workoutExerciseSets <- newSets,
                workoutExerciseReps <- newReps,
                workoutExerciseWeight <- newWeight
            )) ?? 0 > 0 {
                return true
            }
        } catch {
            print("Error updating workout exercise: \(error)")
        }
        return false
    }

    func deleteWorkoutExercise(id: Int64) -> Bool {
        do {
            let exercise = workoutExercises.filter(workoutExerciseID == id)
            if try db?.run(exercise.delete()) ?? 0 > 0 {
                return true
            }
        } catch {
            print("Error deleting workout exercise: \(error)")
        }
        return false
    }
}

