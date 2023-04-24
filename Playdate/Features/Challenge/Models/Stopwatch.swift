//
//  Stopwatch.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 24/04/23.
//

import SwiftUI
import Combine

// MARK: - Stopwatch is running in background, but the remainingSeconds doesn't :(

class Stopwatch: ObservableObject {
    // MARK: - String to show in UI
    @Published private(set) var message = "Not running"

    // MARK: - Is the timer running?
    @Published private(set) var isRunning = false
    
    // MARK: - Time left
    @Published private(set) var remainingSeconds = 0
    
    // MARK: - Time that we're counting from
    private var startTime: Date? {
        didSet {
            saveStartTime()
        }
    }

    // MARK: - The timer
    private var timer: AnyCancellable?

    init() {
        startTime = fetchStartTime()
        remainingSeconds = 30

        if startTime != nil {
            start()
        }
    }
}

// MARK: - Public Interface

extension Stopwatch {
    func start() {
        // MARK: - cancel timer if any
        timer?.cancel()

        if startTime == nil {
            startTime = Date()
        }

        message = ""

        timer = Timer
            .publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard
                    let self = self,
                    let startTime = self.startTime
                else { return }

                let now = Date()
                let elapsed = now.timeIntervalSince(startTime)

                guard elapsed < 30 else {
                    self.stop()
                    return
                }

                self.message = String(format: "%0.1f", elapsed)
                
                let double = Double(self.message)
                let int = floor(double!)
                
                if self.remainingSeconds > 0 {
                    if int == double  {
                        self.remainingSeconds -= 1
                    }
                }
            }

        isRunning = true
    }

    func stop() {
        timer?.cancel()
        timer = nil
        startTime = nil
        isRunning = false
        message = "Not running"
        remainingSeconds = 30
    }
}

// MARK: - Private implementation

private extension Stopwatch {
    func saveStartTime() {
        if let startTime = startTime {
            UserDefaults.standard.set(startTime, forKey: "startTime")
            UserDefaults.standard.set(30, forKey: "remainingSeconds")
        } else {
            UserDefaults.standard.removeObject(forKey: "startTime")
            UserDefaults.standard.removeObject(forKey: "remainingSeconds")
        }
    }

    func fetchStartTime() -> Date? {
        UserDefaults.standard.object(forKey: "startTime") as? Date
    }
}
