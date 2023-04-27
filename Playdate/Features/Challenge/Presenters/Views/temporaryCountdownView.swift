//
//  temporaryCountdownView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 24/04/23.
//

import SwiftUI

// MARK: - The timer runs even though the app is minimized, but still if the app is closed, the timer will reset to 1 day

struct temporaryCountdownView: View {
    var toDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    var body: some View {
        VStack {
            Text("Countdown for Challenge")
            
            Spacer().frame(height: 50)
            
            TimerView(setDate: toDate)
        }
        .font(.system(size: 30))
    }
}

struct temporaryCountdownView_Previews: PreviewProvider {
    static var previews: some View {
        temporaryCountdownView()
    }
}

// MARK: - The stopwatch model is not used

//struct temporaryCountdownView: View {
//    @ObservedObject var stopwatch = Stopwatch()
//
//    var body: some View {
//        VStack {
//            Text("Countdown: \(stopwatch.remainingSeconds / 3600) hours, \((stopwatch.remainingSeconds % 3600) / 60) minutes, \(stopwatch.remainingSeconds % 60) seconds")
//                .font(.headline)
//                .padding()
//
//            Text("Stopwatch: \(stopwatch.message)")
//                .font(.headline)
//                .padding()
//
//            Button(stopwatch.isRunning ? "Stop" : "Start") {
//                if stopwatch.isRunning {
//                    stopwatch.stop()
//                } else {
//                    stopwatch.start()
//                }
//            }
//            .font(.headline)
//            .padding()
//        }
//    }
//}
