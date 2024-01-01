//
//  PlaydateApp.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 19/04/23.
//

import SwiftUI

@main
struct PlaydateApp: App {
    @StateObject var dataManager =  DataManager()
//    @StateObject var memoryViewModel = MemoryViewModel()
    
    // Firebase configure API
    init(){
//        FirebaseApp.configure()
        print("INIT PlaydateApp")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
            
//            MantapView()
            
//                .environmentObject(memoryViewModel)
//            ChallengeViewPage1()
//            GenerateChallengeView()
//            challengeFirebaseExperiment()
//            temporaryCountdownView()
//            MemoryLaneView()
        }
    }
}
