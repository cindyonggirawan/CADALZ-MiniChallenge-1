//
//  challengeFirebaseExperiment.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 20/04/23.
//

import SwiftUI

struct challengeFirebaseExperiment: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            List(dataManager.ChallengesFirebase, id: \.id) { challengeFirebase in
                
                Text("id: \(challengeFirebase.id) like:  \(challengeFirebase.like)")
//                Text("Hello")
            }
            .navigationTitle("Test Firebase")
//            .navigationBarItems(trailing: Button(action:))
        }
    }
}


struct challengeFirebaseExperiment_Previews: PreviewProvider {
    static var previews: some View {
        challengeFirebaseExperiment()
            .environmentObject(DataManager())
    }
}
