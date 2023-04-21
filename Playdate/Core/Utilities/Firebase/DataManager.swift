//
//  DataManager.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 20/04/23.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
    @Published var ChallengesFirebase: [ChallengeFirebase] = []
    
    init(){
        fetchChallengesFirebase()
    }
    
    func fetchChallengesFirebase(){
        ChallengesFirebase.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("ChallengeFirebase")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? Int ?? -1
                    let like = data["like"] as? Int ?? -1
                    let numberOfUser = data["numberOfUser"] as? Int ?? -1
                    
                    let challengeFirebase = ChallengeFirebase(id: id, like: like, numberOfUser: numberOfUser)
                    self.ChallengesFirebase.append(challengeFirebase)
                }
            }
        }
    }
}
