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
    private let workoutExerciseTemplateExerciseID = Expression<Int64>("template_exercise_id")

    private init() {
        db = DatabaseManager.shared.getConnection()
    }

    
    func addWorkoutExercise(workoutID: Int64, templateExerciseID: Int64) -> Int64? {
        do {
            let insert = workoutExercises.insert(
                workoutExerciseWorkoutID <- workoutID,
                workoutExerciseTemplateExerciseID <- templateExerciseID
            )
            let rowID = try db?.run(insert)
            return rowID
        } catch {
            print("Error adding workout exercise: \(error)")
            return nil
        }
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
    
    func getWorkoutExercises(workoutID: Int64) -> [(id: Int64, name: String)] {
        var exercises: [(id: Int64, name: String)] = []
        do {
            if let db = db {
                let query = workoutExercises.filter(workoutExerciseWorkoutID == workoutID)
                for exercise in try db.prepare(query) {
                    let id = exercise[workoutExerciseID]
                    let name = TemplateExerciseManager.shared.getExerciseName(by: exercise[workoutExerciseTemplateExerciseID]) ?? "Unknown Exercise"
                    exercises.append((id: id, name: name))
                }
            }
        } catch {
            print("Error fetching workout exercises: \(error)")
        }
        return exercises
    }

}

