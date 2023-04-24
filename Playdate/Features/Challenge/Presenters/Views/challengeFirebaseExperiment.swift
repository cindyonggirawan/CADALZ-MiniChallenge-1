//
//  challengeFirebaseExperiment.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 20/04/23.
//

import SwiftUI
import Firebase

struct challengeFirebaseExperiment: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            List(dataManager.Challenges, id: \.id) { challenge in
                
                Text("id: \(challenge.id) Name:\(challenge.name) like:  \(challenge.like)")
//                Text("Hello")
            }
            .navigationTitle("Test Firebase")
            .navigationBarItems(trailing: Button(action: {
                let challengeId = 1
                let isLike = true
                updateChallengeLike(challengeId: challengeId, isLike: isLike)
                
            }, label: {
                Image(systemName: "plus")
            }))
        }
        
    }
    
    
    func updateChallengeLike(challengeId: Int, isLike: Bool){
        
        let db = Firestore.firestore()
        
        db.collection("Challenges").whereField("Id", isEqualTo: challengeId).getDocuments {
            (result, error) in
            if error == nil {
                for document in result!.documents {
//                    Check Data
                    let data = document.data()
                    
                    var like = data["Like"] as? Int ?? -1
                    var numberOfUser = data["NumberOfUser"] as? Int ?? -1
                    
                    print("fetched like: \(like) | numberOfUser: \(numberOfUser)")
                    if isLike {
                        like+=1
                    }
                    numberOfUser+=1
                    
//                    Update Data
                    document.reference.setValue(like, forKey: "Like")
                    document.reference.setValue(numberOfUser, forKey: "NumberOfUser")
                }
            }
        }
        print("Updated Like & NumberOfUser challenge id: \(challengeId)")
    }
}


struct challengeFirebaseExperiment_Previews: PreviewProvider {
    static var previews: some View {
        challengeFirebaseExperiment()
            .environmentObject(DataManager())
    }
}
