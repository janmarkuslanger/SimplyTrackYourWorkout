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
    private let templateExerciseSortIndex = Expression<Int>("sort_index")

    private init() {
        db = DatabaseManager.shared.getConnection()
    }

    func createTemplateExercise(templateID: Int64, name: String, sets: Int, sortIndex: Int) -> Int64? {
        do {
            let insert = templateExercises.insert(
                templateExerciseTemplateID <- templateID,
                templateExerciseName <- name,
                templateExerciseSets <- sets,
                templateExerciseSortIndex <- sortIndex
            )
            let rowID = try db?.run(insert)
            return rowID
        } catch {
            print("Error creating template exercise: \(error)")
            return nil
        }
    }

    func readTemplateExercises(templateID: Int64) -> [(id: Int64, name: String, sets: Int, sortIndex: Int)] {
        var exercises: [(id: Int64, name: String, sets: Int, sortIndex: Int)] = []
        do {
            if let db = db {
                let query = templateExercises.filter(templateExerciseTemplateID == templateID)
                for exercise in try db.prepare(query) {
                    let id = exercise[templateExerciseID]
                    let name = exercise[templateExerciseName]
                    let sets = exercise[templateExerciseSets]
                    let sortIndex = exercise[templateExerciseSortIndex]
                    exercises.append((id: id, name: name, sets: sets, sortIndex: sortIndex))
                }
            }
        } catch {
            print("Error reading template exercises: \(error)")
        }
        return exercises
    }
    
    func updateSortIndex(exerciseID: Int64, newSortIndex: Int) -> Bool {
        do {
            let exercise = templateExercises.filter(templateExerciseID == exerciseID)
            if try db?.run(exercise.update(templateExerciseSortIndex <- newSortIndex)) ?? 0 > 0 {
                return true
            }
        } catch {
            print("Error updating sort index for exercise \(exerciseID): \(error)")
        }
        return false
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


