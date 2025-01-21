import SQLite

class WorkoutSetManager {
    static let shared = WorkoutSetManager()
    private let db = DatabaseManager.shared.getConnection()

    func createWorkoutSet(exerciseID: Int64, reps: Int, weight: Int) -> Int64? {
        do {
            let insert = workoutSets.insert(
                workoutSetExerciseID <- exerciseID,
                workoutSetReps <- reps,
                workoutSetWeight <- weight
            )
            let rowID = try db?.run(insert)
            return rowID
        } catch {
            print("Error creating workout set: \(error)")
            return nil
        }
    }

    func readWorkoutSets(exerciseID: Int64) -> [(id: Int64, reps: Int, weight: Int)] {
        var sets: [(id: Int64, reps: Int, weight: Int)] = []
        do {
            let query = workoutSets.filter(workoutSetExerciseID == exerciseID)
            for set in try db?.prepare(query) ?? [] {
                sets.append((
                    id: set[workoutSetID],
                    reps: set[workoutSetReps],
                    weight: set[workoutSetWeight]
                ))
            }
        } catch {
            print("Error reading workout sets: \(error)")
        }
        return sets
    }

    func deleteWorkoutSet(setID: Int64) -> Bool {
        do {
            let set = workoutSets.filter(workoutSetID == setID)
            if try db?.run(set.delete()) ?? 0 > 0 {
                return true
            }
        } catch {
            print("Error deleting workout set: \(error)")
        }
        return false
    }
}
