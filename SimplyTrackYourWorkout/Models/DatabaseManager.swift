//
//  DatabaseManager.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 20.01.25.
//
import SQLite
import Foundation

class DatabaseManager {
    static let shared = DatabaseManager()

    private var db: Connection?

    private let templates = Table("templates")
    private let templateExercises = Table("template_exercises")
    private let workouts = Table("workouts")
    private let workoutExercises = Table("workout_exercises")
    private let workoutSets = Table("workout_sets")

    private let templateID = SQLite.Expression<Int64>("id");
    private let templateName = SQLite.Expression<String>("name")

    private let templateExerciseID = SQLite.Expression<Int64>("id")
    private let templateExerciseTemplateID = SQLite.Expression<Int64>("template_id")
    private let templateExerciseExerciseID = SQLite.Expression<Int64>("exercise_id")
    private let templateExerciseSets = SQLite.Expression<Int>("sets")
    private let templateExerciseSortIndex = SQLite.Expression<Int>("sort_index")

    private let workoutID = SQLite.Expression<Int64>("id")
    private let workoutDate = SQLite.Expression<String>("date")
    private let workoutTemplateID = SQLite.Expression<Int64?>("template_id")

    private let workoutExerciseID = SQLite.Expression<Int64>("id")
    private let workoutExerciseWorkoutID = SQLite.Expression<Int64>("workout_id")
    private let workoutExerciseTemplateExerciseID = SQLite.Expression<Int64>("template_exercise_id")
    
    
    private let workoutSetID = SQLite.Expression<Int64>("id")
    private let workoutSetExerciseID = SQLite.Expression<Int64>("exercise_id")
    private let workoutSetReps = SQLite.Expression<Int>("reps")
    private let workoutSetWeight = SQLite.Expression<Int>("weight")


    private init() {
        do {
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let fileURL = documentDirectory.appendingPathComponent("workouts.sqlite3")
            db = try Connection(fileURL.path)
            try createTables()
        } catch {
            print("Fehler beim Einrichten der Datenbank: \(error)")
        }
    }

    private func createTables() throws {
        try db?.run(templates.create(ifNotExists: true) { t in
            t.column(templateID, primaryKey: true)
            t.column(templateName)
        })

        try db?.run(templateExercises.create(ifNotExists: true) { t in
            t.column(templateExerciseID, primaryKey: true)
            t.column(templateExerciseTemplateID)
            t.column(templateExerciseExerciseID)
            t.column(templateExerciseSets)
            t.column(templateExerciseSortIndex, defaultValue: 0)
        })

        try db?.run(workouts.create(ifNotExists: true) { t in
            t.column(workoutID, primaryKey: true)
            t.column(workoutDate)
            t.column(workoutTemplateID)
        })

        try db?.run(workoutExercises.create(ifNotExists: true) { t in
            t.column(workoutExerciseID, primaryKey: true)
            t.column(workoutExerciseWorkoutID)
            t.column(workoutExerciseTemplateExerciseID)
        })
        
        try db?.run(workoutSets.create(ifNotExists: true) { t in
            t.column(workoutSetID, primaryKey: true)
            t.column(workoutSetExerciseID)
            t.column(workoutSetReps)
            t.column(workoutSetWeight)
        })
    }

    func getConnection() -> Connection? {
        return db
    }
    
    func createTemplate(name: String) -> Int64? {
        do {
            let insert = templates.insert(templateName <- name)
            let rowID = try db?.run(insert)
            return rowID
        } catch {
            print("Error creating template: \(error)")
            return nil
        }
    }

    func readTemplates() -> [String] {
        var result = [String]()
        do {
            if let db = db {
                for template in try db.prepare(templates) {
                    let name = template[templateName]
                    result.append(name)
                }
            }
        } catch {
            print("Error reading templates: \(error)")
        }
        return result
    }


    func updateTemplate(id: Int64, newName: String) -> Bool {
        do {
            let template = templates.filter(templateID == id)
            if try db?.run(template.update(templateName <- newName)) ?? 0 > 0 {
                return true
            }
        } catch {
            print("Error updating template: \(error)")
        }
        return false
    }

    func deleteTemplate(id: Int64) -> Bool {
        do {
            let template = templates.filter(templateID == id)
            if try db?.run(template.delete()) ?? 0 > 0 {
                return true
            }
        } catch {
            print("Error deleting template: \(error)")
        }
        return false
    }

}
