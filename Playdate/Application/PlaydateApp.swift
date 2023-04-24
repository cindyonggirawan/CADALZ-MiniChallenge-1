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
        //TEMP DATA
        challengeViewModel.addChallenge(id: 1, name: "Makan soto betawi di pinggir jalan sambil pakai onesie bareng pasanganmu!", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Food")
        challengeViewModel.addChallenge(id: 2, name: "Makan Bakso Gepeng di pinggir jalan bareng pasanganmu!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Food")
        challengeViewModel.addChallenge(id: 3, name: "Naik kapal bareng pasanganmu sambil nyanyi bareng!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel")
        challengeViewModel.addChallenge(id: 4, name: "Pergi ke landmark kota kamu dan pasanganmu!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel")
        challengeViewModel.addChallenge(id: 5, name: "Makan sie bareng pasanganmu!", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Food")
        challengeViewModel.addChallenge(id: 6, name: "Makan nganmu!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Food")
        challengeViewModel.addChallenge(id: 7, name: " sambil nyanyi bareng!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel")
        challengeViewModel.addChallenge(id: 8, name: "P!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel")
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
