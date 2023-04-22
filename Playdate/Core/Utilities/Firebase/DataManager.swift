//
//  DataManager.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 20/04/23.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
    @Published var Challenges: [ChallengeFB] = []
    
    init(){
        fetchChallenges()
    }
    
    func fetchChallenges(){
        Challenges.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Challenges")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["Id"] as? Int ?? -1
                    let like = data["Like"] as? Int ?? -1
                    let numberOfUser = data["NumberOfUser"] as? Int ?? -1
                    let name = data["Name"] as? String ?? ""
                    let description = data["Description"] as? String ?? ""
                    let challengeCategoryId = data["ChallengeCategoryId"] as? Int ?? -1
                    
                    let challenge = ChallengeFB(
                        name: name,
                        description: description,
                        challengeCategoryId: challengeCategoryId,
                        id: id,
                        like: like,
                        numberOfUser: numberOfUser)
                    
                    self.Challenges.append(challenge)
                }
            }
        }
    }
}
