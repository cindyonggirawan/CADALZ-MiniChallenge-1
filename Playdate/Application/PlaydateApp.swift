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
        
        //TEMP DATA
        challengeViewModel.addChallenge(id: "CL001", name: "Makan soto betawi di pinggir jalan sambil pakai onesie bareng pasanganmu!", desc: "LOREM IPSUM", like: 0, numberOfUser: 0, category: "Food")
        challengeViewModel.addChallenge(id: "CL002", name: "Makan Bakso Gepeng di pinggir jalan bareng pasanganmu!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Food")
        challengeViewModel.addChallenge(id: "CL003", name: "Naik kapal bareng pasanganmu sambil nyanyi bareng!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel")
        challengeViewModel.addChallenge(id: "CL004", name: "Pergi ke landmark kota kamu dan pasanganmu!", desc: "LOREM IPSUM SOMET", like: 0, numberOfUser: 0, category: "Travel")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            GenerateChallengeView()
//            challengeFirebaseExperiment()
//                .environmentObject(dataManager)
        }
    }
}
