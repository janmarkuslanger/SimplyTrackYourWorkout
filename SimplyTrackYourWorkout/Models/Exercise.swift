//
//  Exercise.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//

import Foundation

struct Exercise {
    let id: Int64
    let name: String
    let focus: String
}

struct ExerciseConstants {
    static let exercises: [Int64: Exercise] = [
        1: Exercise(id: 1, name: "Arnold Press", focus: "Shoulders"),
        2: Exercise(id: 2, name: "Bench Press (Barbell)", focus: "Chest"),
        3: Exercise(id: 3, name: "Bench Press (Dumbbell)", focus: "Chest"),
        4: Exercise(id: 4, name: "Bench Press (Close-Grip)", focus: "Triceps"),
        5: Exercise(id: 5, name: "Glute-Bridge", focus: "Glutes"),
        6: Exercise(id: 6, name: "Butterfly Machine", focus: "Chest"),
        7: Exercise(id: 7, name: "Calf Raise (Seated)", focus: "Calves"),
        8: Exercise(id: 8, name: "Calf Raise (Standing)", focus: "Calves"),
        9: Exercise(id: 9, name: "Clean and Jerk", focus: "Full Body"),
        10: Exercise(id: 10, name: "Crossover (Cable)", focus: "Chest"),
        11: Exercise(id: 11, name: "Crunch", focus: "Abs"),
        12: Exercise(id: 12, name: "Crunch (Exercise Ball)", focus: "Abs"),
        13: Exercise(id: 13, name: "Crunch (Kneeling, Cable)", focus: "Abs"),
        14: Exercise(id: 14, name: "Curl (Barbell)", focus: "Biceps"),
        15: Exercise(id: 15, name: "Curl (Concentration)", focus: "Biceps"),
        16: Exercise(id: 16, name: "Curl (Dumbbell)", focus: "Biceps"),
        17: Exercise(id: 17, name: "Curl (EZ-Bar)", focus: "Biceps"),
        18: Exercise(id: 18, name: "Curl (Hammer, Dumbbell)", focus: "Biceps"),
        19: Exercise(id: 19, name: "Curl (Preacher)", focus: "Biceps"),
        20: Exercise(id: 20, name: "Deadlift (Barbell)", focus: "Back"),
        21: Exercise(id: 21, name: "Deadlift (Conventional)", focus: "Back"),
        22: Exercise(id: 22, name: "Deadlift (Dumbbell)", focus: "Legs"),
        23: Exercise(id: 23, name: "Deadlift (Romanian)", focus: "Legs"),
        24: Exercise(id: 24, name: "Deadlift (Sumo)", focus: "Legs"),
        25: Exercise(id: 25, name: "Dip (Triceps)", focus: "Triceps"),
        26: Exercise(id: 26, name: "Farmer's Walk", focus: "Full Body"),
        27: Exercise(id: 27, name: "Fly (Chest, Machine)", focus: "Chest"),
        28: Exercise(id: 28, name: "Fly (Incline, Dumbbell)", focus: "Chest"),
        29: Exercise(id: 29, name: "Fly (Rear Delt, Cable)", focus: "Shoulders"),
        30: Exercise(id: 30, name: "Fly (Rear Delt, Dumbbell)", focus: "Shoulders"),
        31: Exercise(id: 31, name: "Front Raise (Dumbbell)", focus: "Shoulders"),
        32: Exercise(id: 32, name: "Goblet Squat", focus: "Legs"),
        33: Exercise(id: 33, name: "Hack Squat (Machine)", focus: "Legs"),
        34: Exercise(id: 34, name: "Lateral Raise (Cable)", focus: "Shoulders"),
        35: Exercise(id: 35, name: "Lateral Raise (Dumbbell)", focus: "Shoulders"),
        36: Exercise(id: 36, name: "Leg Extension (Machine)", focus: "Legs"),
        37: Exercise(id: 37, name: "Leg Press (Machine)", focus: "Legs"),
        38: Exercise(id: 38, name: "Leg Raise (Hanging)", focus: "Abs"),
        39: Exercise(id: 39, name: "Leg Raise (Vertical)", focus: "Abs"),
        40: Exercise(id: 40, name: "Legcurls (Lying)", focus: "Legs"),
        41: Exercise(id: 41, name: "Legcurl (Seated)", focus: "Legs"),
        42: Exercise(id: 42, name: "Lunges (Barbell)", focus: "Legs"),
        43: Exercise(id: 43, name: "Lunges (Dumbbell)", focus: "Legs"),
        44: Exercise(id: 44, name: "Mountain Climbers", focus: "Full Body"),
        45: Exercise(id: 45, name: "Overhead Press (Barbell)", focus: "Shoulders"),
        46: Exercise(id: 46, name: "Overhead Press (Dumbbell)", focus: "Shoulders"),
        47: Exercise(id: 47, name: "Face-Pulls (Cable)", focus: "Shoulders"),
        48: Exercise(id: 48, name: "Pull-Up (Assisted)", focus: "Back"),
        49: Exercise(id: 49, name: "Pull-Up (Weighted)", focus: "Back"),
        50: Exercise(id: 50, name: "Push-Up (Decline)", focus: "Chest"),
        51: Exercise(id: 51, name: "Push-Up (Incline)", focus: "Chest"),
        52: Exercise(id: 52, name: "Push-Up (Weighted)", focus: "Chest"),
        53: Exercise(id: 53, name: "Row (Bent-Over)", focus: "Back"),
        54: Exercise(id: 54, name: "Row (Cable)", focus: "Back"),
        55: Exercise(id: 55, name: "Row (Seated Cable)", focus: "Back"),
        56: Exercise(id: 56, name: "Row (T-Bar)", focus: "Back"),
        57: Exercise(id: 57, name: "Row (Upright, Barbell)", focus: "Shoulders"),
        58: Exercise(id: 58, name: "Row (Upright, Dumbbell)", focus: "Shoulders"),
        59: Exercise(id: 59, name: "Russian Twist", focus: "Abs"),
        60: Exercise(id: 60, name: "Sissy Squat", focus: "Legs"),
        61: Exercise(id: 61, name: "Skull Crusher", focus: "Triceps"),
        62: Exercise(id: 62, name: "Sled Push", focus: "Legs"),
        63: Exercise(id: 63, name: "Split Squat", focus: "Legs"),
        64: Exercise(id: 64, name: "Squat (Back)", focus: "Legs"),
        65: Exercise(id: 65, name: "Squat (Bodyweight)", focus: "Legs"),
        66: Exercise(id: 66, name: "Squat (Goblet)", focus: "Legs"),
        67: Exercise(id: 67, name: "Squat (Front)", focus: "Legs"),
        68: Exercise(id: 68, name: "Squat (Pistol)", focus: "Legs"),
        69: Exercise(id: 69, name: "Thrust (Hip)", focus: "Glutes"),
        70: Exercise(id: 70, name: "Twist (Russian)", focus: "Abs"),
        71: Exercise(id: 71, name: "Wall Sit", focus: "Legs"),
        72: Exercise(id: 72, name: "Y-Raise (Dumbbell or Cable)", focus: "Shoulders"),
        73: Exercise(id: 73, name: "Pull Down (Single-Arm)", focus: "Lats & Obliques"),
        74: Exercise(id: 74, name: "Pull Down (Wide-Grip)", focus: "Lats & Upper Back"),
        75: Exercise(id: 75, name: "Pull Down (Close-Grip)", focus: "Middle Back & Biceps"),
        76: Exercise(id: 76, name: "Pull Down (Neutral-Grip)", focus: "Lats & Middle Back"),
        77: Exercise(id: 77, name: "Pull Down (Behind-the-Neck)", focus: "Lats & Traps"),
        78: Exercise(id: 78, name: "Pull Down (Straight Arm)", focus: "Lats & Core"),
        79: Exercise(id: 79, name: "Pull Down (Reverse)", focus: "Lats & Biceps"),
        80: Exercise(id: 80, name: "Pull Down (Dual Cable)", focus: "Lats & Unilateral Strength")
    ]
}
