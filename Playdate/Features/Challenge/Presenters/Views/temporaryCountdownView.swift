//
//  CountdownView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 24/04/23.
//

import SwiftUI

struct temporaryCountdownView: View {
    @ObservedObject var stopwatch = Stopwatch()
    
    var body: some View {
        VStack {
            Text("Countdown: \(stopwatch.remainingSeconds / 3600) hours, \((stopwatch.remainingSeconds % 3600) / 60) minutes, \(stopwatch.remainingSeconds % 60) seconds")
                .font(.headline)
                .padding()
            
            Text("Stopwatch: \(stopwatch.message)")
                .font(.headline)
                .padding()
            
            Button(stopwatch.isRunning ? "Stop" : "Start") {
                if stopwatch.isRunning {
                    stopwatch.stop()
                } else {
                    stopwatch.start()
                }
            }
            .font(.headline)
            .padding()
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        temporaryCountdownView()
    }
}
