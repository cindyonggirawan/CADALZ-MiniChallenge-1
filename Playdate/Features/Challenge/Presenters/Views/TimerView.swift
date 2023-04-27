//
//  TimerView.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 27/04/23.
//

import SwiftUI

struct TimerView: View {
    @State var nowDate: Date = Date()
    
    let setDate: Date
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        Text(TimerFunction(from: setDate))
            .onAppear(perform: {
                self.timer
            })
    }
    
    func TimerFunction(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        
        let timeValue = calendar
            .dateComponents([.day, .hour, .minute, .second], from: nowDate, to: setDate)
        
//        Bawaan code
//        return String(format: "%02d days left - %02d:%02d:%02d", timeValue.day!, timeValue.hour!, timeValue.minute!, timeValue.second!)
        
        return String(format: "%02d:%02d:%02d", timeValue.hour!, timeValue.minute!, timeValue.second!)
    }
}
