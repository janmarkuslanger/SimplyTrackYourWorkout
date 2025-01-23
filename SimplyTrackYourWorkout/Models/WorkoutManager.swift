//
//  WorkoutManager.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//
import SQLite

class WorkoutManager {
    static let shared = WorkoutManager()

    private let db: Connection?

    private let workouts = Table("workouts")
    private let workoutID = Expression<Int64>("id")
    private let workoutDate = Expression<String>("date")
    private let workoutTemplateID = Expression<Int64?>("template_id")

    private init() {
        db = DatabaseManager.shared.getConnection()
    }

    func createWorkout(date: String, templateID: Int64?) -> Int64? {
        do {
            let insert = workouts.insert(
                workoutDate <- date,
                workoutTemplateID <- templateID
            )
            let rowID = try db?.run(insert)
            return rowID
        } catch {
            print("Error creating workout: \(error)")
            return nil
        }
    }

    func readWorkouts() -> [(id: Int64, date: String, templateID: Int64?)] {
        var result: [(id: Int64, date: String, templateID: Int64?)] = []
        do {
            if let db = db {
                for workout in try db.prepare(workouts) {
                    let id = workout[workoutID]
                    let date = workout[workoutDate]
                    let templateID = workout[workoutTemplateID]
                    result.append((id: id, date: date, templateID: templateID))
                }
            }
        } catch {
            print("Error reading workouts: \(error)")
        }
        return result
    }

    func updateWorkout(id: Int64, newDate: String, newTemplateID: Int64?) -> Bool {
        do {
            let workout = workouts.filter(workoutID == id)
            if try db?.run(workout.update(
                workoutDate <- newDate,
                workoutTemplateID <- newTemplateID
            )) ?? 0 > 0 {
                return true
            }
        } catch {
            print("Error updating workout: \(error)")
        }
        return false
    }

    func deleteWorkout(id: Int64) -> Bool {
        do {
            let workout = workouts.filter(workoutID == id)
            if try db?.run(workout.delete()) ?? 0 > 0 {
                return true
            }
        } catch {
            print("Error deleting workout: \(error)")
        }
        return false
    }
    
}


