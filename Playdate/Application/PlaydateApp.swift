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
    let challengeViewModel = ChallengeViewModel()
    
    // Firebase configure API
    init(){
        FirebaseApp.configure()
//        TEMP DATA
//        challengeViewModel.addChallenge(id: "CL001", name: "a", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Food"); challengeViewModel.addChallenge(id: "CL002", name: "b", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Food"); challengeViewModel.addChallenge(id: "CL006", name: "f", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Food"); challengeViewModel.addChallenge(id: "CL005", name: "e", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Food"); challengeViewModel.addChallenge(id: "CL009", name: "i", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Food"); challengeViewModel.addChallenge(id: "CL010", name: "j", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Food"); challengeViewModel.addChallenge(id: "CL013", name: "M", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Food"); challengeViewModel.addChallenge(id: "CL014", name: "n", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Food")
//        challengeViewModel.addChallenge(id: "CL003", name: "c", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Entertainment"); challengeViewModel.addChallenge(id: "CL011", name: "k", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Entertainment"); challengeViewModel.addChallenge(id: "CL003", name: "c", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Entertainment"); challengeViewModel.addChallenge(id: "CL011", name: "k", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Entertainment"); challengeViewModel.addChallenge(id: "CL003", name: "c", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Entertainment"); challengeViewModel.addChallenge(id: "CL011", name: "k", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Entertainment"); challengeViewModel.addChallenge(id: "CL003", name: "c", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Entertainment"); challengeViewModel.addChallenge(id: "CL011", name: "k", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Entertainment")
//        challengeViewModel.addChallenge(id: "CL004", name: "d", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel"); challengeViewModel.addChallenge(id: "CL007", name: "g", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel"); challengeViewModel.addChallenge(id: "CL008", name: "h", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel"); challengeViewModel.addChallenge(id: "CL012", name: "l", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel"); challengeViewModel.addChallenge(id: "CL015", name: "o", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel"); challengeViewModel.addChallenge(id: "CL016", name: "P", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel"); challengeViewModel.addChallenge(id: "CL004", name: "d", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel"); challengeViewModel.addChallenge(id: "CL007", name: "g", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel")
//        challengeViewModel.addChallenge(id: "CL001", name: "a", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Well-being"); challengeViewModel.addChallenge(id: "CL002", name: "b", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Well-being"); challengeViewModel.addChallenge(id: "CL005", name: "e", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Well-being"); challengeViewModel.addChallenge(id: "CL006", name: "f", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Well-being"); challengeViewModel.addChallenge(id: "CL008", name: "h", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Well-being"); challengeViewModel.addChallenge(id: "CL009", name: "i", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Well-being"); challengeViewModel.addChallenge(id: "CL010", name: "j", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Well-being"); challengeViewModel.addChallenge(id: "CL013", name: "M", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Well-being")
    }
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            GenerateChallengeView()
//            challengeFirebaseExperiment()
//                .environmentObject(dataManager)
//            temporaryCountdownView()
        }
    }
}
