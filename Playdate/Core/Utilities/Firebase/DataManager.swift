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
    @ObservedObject var challengeViewModel: ChallengeViewModel
    
    init(){
        self.challengeViewModel = ChallengeViewModel()
        fetchChallenges()
//        syncWithFirebase()
    }
    
//    func syncWithFirebase() {
//        if Reachability.isConnectedToNetwork() {
//            fetchChallenges()
//            print(Challenges.count)
//            if( Challenges.count != 0) {
//                // Sync with Firebase
//                for challenge in Challenges {
//                    print("id: \(challenge.id) | name: \(challenge.name)")
//                    challengeViewModel.updateChallenge(
//                        id: challenge.id,
//                        name: challenge.name,
//                        desc: challenge.description,
//                        like: Int(challenge.like),
//                        numberOfUser: Int(challenge.numberOfUser),
//                        category: challenge.category)
//                }
//            } else {
//                // Failed to sync
//                print("Sync Failed")
//            }
//        } else {
//            print("No Internet Connection")
//        }
//    }
    
    func syncWithFirebase(){
        print(Challenges.count)
        if( Challenges.count != 0) {
            // Sync with Firebase
            for challenge in Challenges {
                print("id: \(challenge.id) | name: \(challenge.name)")
                challengeViewModel.updateChallenge(
                    id: challenge.id,
                    name: challenge.name,
                    desc: challenge.description,
                    like: Int(challenge.like),
                    numberOfUser: Int(challenge.numberOfUser),
                    category: challenge.category)
            }
        } else {
            // Failed to sync
            print("Sync Failed")
        }
    }
    
    func fetchChallenges(){
        Challenges.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("ChallengesBatch2")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["Id"] as? String ?? ""
                    let like = data["Like"] as? Int ?? -1
                    let numberOfUser = data["NumberOfUser"] as? Int ?? -1
                    let name = data["Name"] as? String ?? ""
                    let description = data["Description"] as? String ?? ""
                    let category = data["Category"] as? String ?? ""
                    
                    let challenge = ChallengeFB(
                        name: name,
                        description: description,
                        category: category,
                        id: id,
                        like: like,
                        numberOfUser: numberOfUser)
                    
                    self.Challenges.append(challenge)
                }
            }
        }
    }
    
    func addUser(id: String, name: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(id)
        ref.setData(["id": id, "name": name]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteUser(id: String, name: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Users").document(id)
        ref.delete() { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
