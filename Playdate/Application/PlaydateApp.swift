//
//  PlaydateApp.swift
//  Playdate
//
//  Created by Cindy Amanda Onggirawan on 19/04/23.
//

import SwiftUI
import Firebase

@main
struct PlaydateApp: App {
    @StateObject var dataManager =  DataManager()
    
    // Firebase configure API
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
//            GenerateChallengeView()
//            challengeFirebaseExperiment()
//            temporaryCountdownView()
        }
    }
}
