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
        Exercise(name: "Assisted Pull-Up", focus: "Back"),
        Exercise(name: "Atlas Stone Lift", focus: "Full Body"),
        
        // B
        Exercise(name: "Back Squat", focus: "Legs"),
        Exercise(name: "Barbell Bench Press", focus: "Chest"),
        Exercise(name: "Barbell Curl", focus: "Biceps"),
        Exercise(name: "Barbell Deadlift", focus: "Back"),
        Exercise(name: "Barbell Front Squat", focus: "Legs"),
        Exercise(name: "Barbell Overhead Press", focus: "Shoulders"),
        Exercise(name: "Bench Press (Dumbbell)", focus: "Chest"),
        Exercise(name: "Bent-Over Row", focus: "Back"),
        Exercise(name: "Bodyweight Squat", focus: "Legs"),
        Exercise(name: "Bulgarian Split Squat", focus: "Legs"),
        Exercise(name: "Butterfly Machine", focus: "Chest"),
        
        // C
        Exercise(name: "Cable Crossover", focus: "Chest"),
        Exercise(name: "Cable Lateral Raise", focus: "Shoulders"),
        Exercise(name: "Cable Row", focus: "Back"),
        Exercise(name: "Calf Raise (Seated)", focus: "Calves"),
        Exercise(name: "Calf Raise (Standing)", focus: "Calves"),
        Exercise(name: "Chest Fly (Machine)", focus: "Chest"),
        Exercise(name: "Chin-Up", focus: "Back"),
        Exercise(name: "Clean and Jerk", focus: "Full Body"),
        Exercise(name: "Close-Grip Bench Press", focus: "Triceps"),
        Exercise(name: "Concentration Curl", focus: "Biceps"),
        Exercise(name: "Conventional Deadlift", focus: "Back"),
        Exercise(name: "Crunches", focus: "Abs"),
        
        // D
        Exercise(name: "Deadlift (Romanian)", focus: "Hamstrings"),
        Exercise(name: "Deadlift (Sumo)", focus: "Legs"),
        Exercise(name: "Decline Bench Press", focus: "Chest"),
        Exercise(name: "Decline Push-Up", focus: "Chest"),
        Exercise(name: "Dumbbell Curl", focus: "Biceps"),
        Exercise(name: "Dumbbell Deadlift", focus: "Legs"),
        Exercise(name: "Dumbbell Front Raise", focus: "Shoulders"),
        Exercise(name: "Dumbbell Lateral Raise", focus: "Shoulders"),
        
        // E
        Exercise(name: "EZ-Bar Curl", focus: "Biceps"),
        Exercise(name: "Exercise Ball Crunch", focus: "Abs"),
        Exercise(name: "External Rotation (Cable or Dumbbell)", focus: "Shoulders"),
        
        // F
        Exercise(name: "Face Pull (Cable)", focus: "Shoulders"),
        Exercise(name: "Farmer's Walk", focus: "Full Body"),
        Exercise(name: "Flat Bench Press", focus: "Chest"),
        Exercise(name: "Flat Dumbbell Press", focus: "Chest"),
        Exercise(name: "Front Squat", focus: "Legs"),
        Exercise(name: "Front Raise (Dumbbell)", focus: "Shoulders"),
        
        // G
        Exercise(name: "Goblet Squat", focus: "Legs"),
        Exercise(name: "Good Morning (Barbell)", focus: "Hamstrings"),
        Exercise(name: "Glute Bridge", focus: "Glutes"),
        Exercise(name: "Glute Kickback (Cable or Machine)", focus: "Glutes"),
        
        // H
        Exercise(name: "Hammer Curl (Dumbbell)", focus: "Biceps"),
        Exercise(name: "Hanging Leg Raise", focus: "Abs"),
        Exercise(name: "Hip Abduction (Machine)", focus: "Glutes"),
        Exercise(name: "Hip Thrust", focus: "Glutes"),
        Exercise(name: "Hack Squat (Machine)", focus: "Legs"),
        
        // I
        Exercise(name: "Incline Bench Press (Barbell)", focus: "Chest"),
        Exercise(name: "Incline Bench Press (Dumbbell)", focus: "Chest"),
        Exercise(name: "Incline Dumbbell Fly", focus: "Chest"),
        Exercise(name: "Incline Push-Up", focus: "Chest"),
        
        // K
        Exercise(name: "Kettlebell Swing", focus: "Full Body"),
        Exercise(name: "Kettlebell Goblet Squat", focus: "Legs"),
        Exercise(name: "Kettlebell Clean and Press", focus: "Full Body"),
        Exercise(name: "Kneeling Cable Crunch", focus: "Abs"),
        
        // L
        Exercise(name: "Lat Pulldown", focus: "Back"),
        Exercise(name: "Lateral Raise (Dumbbell or Cable)", focus: "Shoulders"),
        Exercise(name: "Leg Curl (Seated)", focus: "Hamstrings"),
        Exercise(name: "Leg Curl (Lying)", focus: "Hamstrings"),
        Exercise(name: "Leg Extension (Machine)", focus: "Quads"),
        Exercise(name: "Leg Press (Machine)", focus: "Legs"),
        Exercise(name: "Lunges (Walking)", focus: "Legs"),
        Exercise(name: "Lunges (Static)", focus: "Legs"),
        
        // M
        Exercise(name: "Machine Chest Press", focus: "Chest"),
        Exercise(name: "Machine Shoulder Press", focus: "Shoulders"),
        Exercise(name: "Mountain Climbers", focus: "Full Body"),
        
        // O
        Exercise(name: "Overhead Press (Barbell)", focus: "Shoulders"),
        Exercise(name: "Overhead Press (Dumbbell)", focus: "Shoulders"),
        Exercise(name: "Overhead Triceps Extension", focus: "Triceps"),
        
        // P
        Exercise(name: "Pistol Squat", focus: "Legs"),
        Exercise(name: "Plank", focus: "Abs"),
        Exercise(name: "Preacher Curl", focus: "Biceps"),
        Exercise(name: "Pull-Up", focus: "Back"),
        Exercise(name: "Push-Up", focus: "Chest"),
        Exercise(name: "Push Press", focus: "Shoulders"),
        
        // R
        Exercise(name: "Rear Delt Fly (Dumbbell)", focus: "Shoulders"),
        Exercise(name: "Rear Delt Fly (Cable)", focus: "Shoulders"),
        Exercise(name: "Romanian Deadlift", focus: "Hamstrings"),
        Exercise(name: "Rope Pushdown (Triceps)", focus: "Triceps"),
        Exercise(name: "Row (Seated Cable)", focus: "Back"),
        Exercise(name: "Russian Twist", focus: "Abs"),
        
        // S
        Exercise(name: "Side Plank", focus: "Abs"),
        Exercise(name: "Sissy Squat", focus: "Quads"),
        Exercise(name: "Skull Crusher", focus: "Triceps"),
        Exercise(name: "Sled Push", focus: "Legs"),
        Exercise(name: "Smith Machine Bench Press", focus: "Chest"),
        Exercise(name: "Smith Machine Squat", focus: "Legs"),
        Exercise(name: "Split Squat", focus: "Legs"),
        Exercise(name: "Step-Ups", focus: "Legs"),
        
        // T
        Exercise(name: "T-Bar Row", focus: "Back"),
        Exercise(name: "Triceps Dip", focus: "Triceps"),
        Exercise(name: "Triceps Extension (Cable or Dumbbell)", focus: "Triceps"),
        
        // U
        Exercise(name: "Upright Row (Barbell)", focus: "Shoulders"),
        Exercise(name: "Upright Row (Dumbbell)", focus: "Shoulders"),
        
        // V
        Exercise(name: "Vertical Leg Raise", focus: "Abs"),
        Exercise(name: "V-Up", focus: "Abs"),
        
        // W
        Exercise(name: "Wall Sit", focus: "Legs"),
        Exercise(name: "Weighted Pull-Up", focus: "Back"),
        Exercise(name: "Weighted Push-Up", focus: "Chest"),
        Exercise(name: "Wide-Grip Pull-Up", focus: "Back"),
        
        // Y
        Exercise(name: "Y-Raise (Dumbbell or Cable)", focus: "Shoulders")
    ]
}

