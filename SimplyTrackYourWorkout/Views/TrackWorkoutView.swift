//
//  TrackWorkoutView.swift
//  SimplyTrackYourWorkout
//
//  Created by Jan-Markus Langer on 21.01.25.
//


import SwiftUI

struct TrackWorkoutView: View {
    let templateID: Int64
    let templateName: String

    var body: some View {
        VStack {
            Text("Track Workout")
                .font(.largeTitle)
                .padding()

            Text("Template: \(templateName)")
                .font(.title2)
                .padding()

            Spacer()
        }
        .navigationTitle("Workout")
    }
}
