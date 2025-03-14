//
//  WorkoutSetManager.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//


import SQLite

class WorkoutSetManager {
    static let shared = WorkoutSetManager()
    private let db = DatabaseManager.shared.getConnection()
    
    private let workoutSets = Table("workout_sets")
    private let workoutSetID = Expression<Int64>("id")
    private let workoutSetExerciseID = Expression<Int64>("exercise_id")
    private let workoutSetReps = Expression<Int>("reps")
    private let workoutSetWeight = Expression<Int>("weight")

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
    
    func getLastWorkoutSetsForExercise(templateExerciseID: Int64) -> [(reps: Int, weight: Int)] {
        var lastSets: [(reps: Int, weight: Int)] = []
        
        guard let workoutExerciseId = WorkoutExerciseManager.shared.getLastExerciseId(templateExerciseId: templateExerciseID) else {
                return [(reps: 0, weight: 0)]
            }
        
        do {
            let query = workoutSets
                .filter(workoutSetExerciseID == workoutExerciseId)
                .order(workoutSetID)

            if let db = db {
                for set in try db.prepare(query) {
                    lastSets.append((reps: set[workoutSetReps], weight: set[workoutSetWeight]))
                }
            }
        } catch {
            print("Error fetching last workout sets: \(error)")
        }
        return lastSets
    }
    
    func readWorkoutSets(exerciseID: Int64) -> [(reps: Int, weight: Int)] {
        var sets: [(reps: Int, weight: Int)] = []
        do {
            if let db = db {
                let query = workoutSets.filter(workoutSetExerciseID == exerciseID)
                for set in try db.prepare(query) {
                    sets.append((reps: set[workoutSetReps], weight: set[workoutSetWeight]))
                }
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
