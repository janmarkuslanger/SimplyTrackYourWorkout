//
//  TemplateExerciseManager.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//
import SQLite

class TemplateExerciseManager {
    static let shared = TemplateExerciseManager()

    private let db: Connection?

    private let templateExercises = Table("template_exercises")
    private let templateExerciseID = Expression<Int64>("id")
    private let templateExerciseTemplateID = Expression<Int64>("template_id")
    private let templateExerciseName = Expression<String>("name")
    private let templateExerciseSets = Expression<Int>("sets")

    private init() {
        db = DatabaseManager.shared.getConnection()
    }

    func createTemplateExercise(templateID: Int64, name: String, sets: Int) -> Int64? {
        do {
            let insert = templateExercises.insert(
                templateExerciseTemplateID <- templateID,
                templateExerciseName <- name,
                templateExerciseSets <- sets
            )
            let rowID = try db?.run(insert)
            return rowID
        } catch {
            print("Error creating template exercise: \(error)")
            return nil
        }
    }

    func readTemplateExercises(templateID: Int64) -> [(name: String, sets: Int)] {
        var exercises: [(name: String, sets: Int)] = []
        do {
            if let db = db {
                let query = templateExercises.filter(templateExerciseTemplateID == templateID)
                for exercise in try db.prepare(query) {
                    let name = exercise[templateExerciseName]
                    let sets = exercise[templateExerciseSets]
                    exercises.append((name, sets))
                }
            }
        } catch {
            print("Error reading template exercises: \(error)")
        }
        return exercises
    }

    func updateTemplateExercise(id: Int64, newName: String, newSets: Int) -> Bool {
        do {
            let exercise = templateExercises.filter(templateExerciseID == id)
            if try db?.run(exercise.update(
                templateExerciseName <- newName,
                templateExerciseSets <- newSets
            )) ?? 0 > 0 {
                return true
            }
        } catch {
            print("Error updating template exercise: \(error)")
        }
        return false
    }

    func deleteTemplateExercise(id: Int64) -> Bool {
        do {
            let exercise = templateExercises.filter(templateExerciseID == id)
            if try db?.run(exercise.delete()) ?? 0 > 0 {
                return true
            }
        } catch {
            print("Error deleting template exercise: \(error)")
        }
        return false
    }
}


