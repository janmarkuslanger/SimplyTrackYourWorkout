//
//  Exercise.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//

import Foundation

struct Exercise {
    let name: String
    let focus: String
}

struct ExerciseConstants {
    static let exercises = [
        // A
        Exercise(name: "Arnold Press", focus: "Shoulders"),
        
        // B
        Exercise(name: "Bench Press (Barbell)", focus: "Chest"),
        Exercise(name: "Bench Press (Dumbbell)", focus: "Chest"),
        Exercise(name: "Bench Press (Close-Grip)", focus: "Triceps"),
        Exercise(name: "Glute-Bridge", focus: "Glutes"),
        Exercise(name: "Butterfly Machine", focus: "Chest"),
        
        // C
        Exercise(name: "Calf Raise (Seated)", focus: "Calves"),
        Exercise(name: "Calf Raise (Standing)", focus: "Calves"),
        Exercise(name: "Clean and Jerk", focus: "Full Body"),
        Exercise(name: "Crossover (Cable)", focus: "Chest"),
        Exercise(name: "Crunch", focus: "Abs"),
        Exercise(name: "Crunch (Exercise Ball)", focus: "Abs"),
        Exercise(name: "Crunch (Kneeling, Cable)", focus: "Abs"),
        Exercise(name: "Curl (Barbell)", focus: "Biceps"),
        Exercise(name: "Curl (Concentration)", focus: "Biceps"),
        Exercise(name: "Curl (Dumbbell)", focus: "Biceps"),
        Exercise(name: "Curl (EZ-Bar)", focus: "Biceps"),
        Exercise(name: "Curl (Hammer, Dumbbell)", focus: "Biceps"),
        Exercise(name: "Curl (Preacher)", focus: "Biceps"),
        
        // D
        Exercise(name: "Deadlift (Barbell)", focus: "Back"),
        Exercise(name: "Deadlift (Conventional)", focus: "Back"),
        Exercise(name: "Deadlift (Dumbbell)", focus: "Legs"),
        Exercise(name: "Deadlift (Romanian)", focus: "Legs"),
        Exercise(name: "Deadlift (Sumo)", focus: "Legs"),
        Exercise(name: "Dip (Triceps)", focus: "Triceps"),
        
        // F
        Exercise(name: "Farmer's Walk", focus: "Full Body"),
        Exercise(name: "Fly (Chest, Machine)", focus: "Chest"),
        Exercise(name: "Fly (Incline, Dumbbell)", focus: "Chest"),
        Exercise(name: "Fly (Rear Delt, Cable)", focus: "Shoulders"),
        Exercise(name: "Fly (Rear Delt, Dumbbell)", focus: "Shoulders"),
        Exercise(name: "Front Raise (Dumbbell)", focus: "Shoulders"),
        Exercise(name: "Goblet Squat", focus: "Legs"),
        
        // H
        Exercise(name: "Hack Squat (Machine)", focus: "Legs"),
        
        // L
        Exercise(name: "Lateral Raise (Cable)", focus: "Shoulders"),
        Exercise(name: "Lateral Raise (Dumbbell)", focus: "Shoulders"),
        Exercise(name: "Leg Extension (Machine)", focus: "Legs"),
        Exercise(name: "Leg Press (Machine)", focus: "Legs"),
        Exercise(name: "Leg Raise (Hanging)", focus: "Abs"),
        Exercise(name: "Leg Raise (Vertical)", focus: "Abs"),
        Exercise(name: "Legcurls (Lying)", focus: "Legs"),
        Exercise(name: "Legcurl (Seated)", focus: "Legs"),
        Exercise(name: "Legcurl (Seated)", focus: "Legs"),
        Exercise(name: "Lunges (Barbell)", focus: "Legs"),
        Exercise(name: "Lunges (Dumbbell)", focus: "Legs"),
        
        // M
        Exercise(name: "Mountain Climbers", focus: "Full Body"),
        
        // O
        Exercise(name: "Overhead Press (Barbell)", focus: "Shoulders"),
        Exercise(name: "Overhead Press (Dumbbell)", focus: "Shoulders"),
        Exercise(name: "Face-Pulls (Cable)", focus: "Shoulders"),
        Exercise(name: "Pull-Up (Assisted)", focus: "Back"),
        Exercise(name: "Pull-Up (Weighted)", focus: "Back"),
        
        // P
        Exercise(name: "Push-Up (Decline)", focus: "Chest"),
        Exercise(name: "Push-Up (Incline)", focus: "Chest"),
        Exercise(name: "Push-Up (Weighted)", focus: "Chest"),
        
        // R
        Exercise(name: "Row (Bent-Over)", focus: "Back"),
        Exercise(name: "Row (Cable)", focus: "Back"),
        Exercise(name: "Row (Seated Cable)", focus: "Back"),
        Exercise(name: "Row (T-Bar)", focus: "Back"),
        Exercise(name: "Row (Upright, Barbell)", focus: "Shoulders"),
        Exercise(name: "Row (Upright, Dumbbell)", focus: "Shoulders"),
        Exercise(name: "Russian Twist", focus: "Abs"),
        
        // S
        Exercise(name: "Sissy Squat", focus: "Legs"),
        Exercise(name: "Skull Crusher", focus: "Triceps"),
        Exercise(name: "Sled Push", focus: "Legs"),
        Exercise(name: "Split Squat", focus: "Legs"),
        Exercise(name: "Squat (Back)", focus: "Legs"),
        Exercise(name: "Squat (Bodyweight)", focus: "Legs"),
        Exercise(name: "Squat (Goblet)", focus: "Legs"),
        Exercise(name: "Squat (Front)", focus: "Legs"),
        Exercise(name: "Squat (Pistol)", focus: "Legs"),
        
        // T
        Exercise(name: "Thrust (Hip)", focus: "Glutes"),
        Exercise(name: "Twist (Russian)", focus: "Abs"),
        
        // W
        Exercise(name: "Wall Sit", focus: "Legs"),
        Exercise(name: "Y-Raise (Dumbbell or Cable)", focus: "Shoulders")
    ]
}
