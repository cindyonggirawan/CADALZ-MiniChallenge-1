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
        
//        challengeViewModel.clearChallenges()
//
//        if dataManager.Challenges.count != 0 {
//            for i in 0...dataManager.Challenges.count{
//                let challenge = dataManager.Challenges[i]
//                challengeViewModel.addChallenge(id: challenge.id, name: challenge.name, desc: challenge.description, like: challenge.like, numberOfUser: challenge.numberOfUser, category: challenge.category)
//            }
//        }
        
        
//        print(challengeViewModel.challenges)
//        TEMP DATA
//        challengeViewModel.addChallenge(id: "CL001", name: "Makan soto betawi di pinggir jalan sambil pakai onesie bareng pasanganmu!", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Food")
//        challengeViewModel.addChallenge(id: "CL002", name: "Makan Bakso Gepeng di pinggir jalan bareng pasanganmu!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Food")
//        challengeViewModel.addChallenge(id: "CL003", name: "Naik kapal bareng pasanganmu sambil nyanyi bareng!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Entertainment")
//        challengeViewModel.addChallenge(id: "CL004", name: "Pergi ke landmark kota kamu dan pasanganmu!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel")
//        challengeViewModel.addChallenge(id: "CL005", name: "Makan sie bareng pasanganmu!", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Food")
//        challengeViewModel.addChallenge(id: "CL006", name: "Makan nganmu!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Food")
//        challengeViewModel.addChallenge(id: "CL007", name: "sambil nyanyi bareng!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel")
//        challengeViewModel.addChallenge(id: "CL008", name: "P!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel")
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
