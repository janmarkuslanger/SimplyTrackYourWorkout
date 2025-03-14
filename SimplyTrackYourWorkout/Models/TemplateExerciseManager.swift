import SQLite

class TemplateExerciseManager {
    static let shared = TemplateExerciseManager()

    private let db: Connection?

    private let templateExercises = Table("template_exercises")
    private let templateExerciseID = Expression<Int64>("id")
    private let templateExerciseTemplateID = Expression<Int64>("template_id")
    private let templateExerciseExerciseID = Expression<Int64>("exercise_id")
    private let templateExerciseSets = Expression<Int>("sets")
    private let templateExerciseSortIndex = Expression<Int>("sort_index")

    private init() {
        db = DatabaseManager.shared.getConnection()
    }

    func createTemplateExercise(templateID: Int64, exerciseID: Int64, sets: Int, sortIndex: Int) -> Int64? {
        do {
            let insert = templateExercises.insert(
                templateExerciseTemplateID <- templateID,
                templateExerciseExerciseID <- exerciseID,
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

    func readTemplateExercises(templateID: Int64) -> [(id: Int64, exerciseID: Int64, sets: Int, sortIndex: Int)] {
        var exercises: [(id: Int64, exerciseID: Int64, sets: Int, sortIndex: Int)] = []
        do {
            if let db = db {
                let query = templateExercises.filter(templateExerciseTemplateID == templateID)
                for exercise in try db.prepare(query) {
                    let id = exercise[templateExerciseID]
                    let exerciseID = exercise[templateExerciseExerciseID]
                    let sets = exercise[templateExerciseSets]
                    let sortIndex = exercise[templateExerciseSortIndex]
                    exercises.append((id: id, exerciseID: exerciseID, sets: sets, sortIndex: sortIndex))
                }
            }
        } catch {
            print("Error reading template exercises: \(error)")
        }
        
        exercises.sort { $0.sortIndex < $1.sortIndex }
            
        return exercises
    }

    func updateSortIndex(exerciseID: Int64, newSortIndex: Int) -> Bool {
        do {
            guard let db = db else {
                print("Database connection is nil")
                return false
            }

            let exercise = templateExercises.filter(templateExerciseID == exerciseID)
            let rowsUpdated = try db.run(exercise.update(templateExerciseSortIndex <- newSortIndex))

            if rowsUpdated > 0 {
                return true
            }
        } catch {
            print("Error updating sortIndex: \(error)")
        }
        return false
    }

    func updateTemplateExerciseSets(id: Int64, newSets: Int) -> Bool {
        do {
            let exercise = templateExercises.filter(templateExerciseID == id)
            if try db?.run(exercise.update(
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
    
    func getExerciseID(byTemplateExerciseID id: Int64) -> Int64?{
        do {
            if let db = db {
                let query = templateExercises.filter(templateExerciseID == id)
                if let exercise = try db.pluck(query) {
                    return exercise[templateExerciseExerciseID]
                }
            }
        } catch {
            print("Error fetching exercise ID: \(error)")
        }
        return nil
    }

    func getExerciseDetails(by exerciseID: Int64) -> Exercise? {
        return ExerciseConstants.exercises[Int64(exerciseID)]
    }
    
    func deleteTemplateExercises(byTemplateID templateID: Int64) -> Bool {
        do {
            if let db = db {
                let query = templateExercises.filter(templateExerciseTemplateID == templateID)
                try db.run(query.delete())
                print("All template exercises for templateID \(templateID) have been deleted.")
                return true
            }
        } catch {
            print("Error deleting template exercises for templateID \(templateID): \(error)")
        }
        return false
    }
}
