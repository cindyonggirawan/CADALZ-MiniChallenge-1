//
//  DataManager.swift
//  Playdate
//
//  Created by Louis Mayco Dillon Wijaya on 20/04/23.
//

import SwiftUI

struct ChallengesJson: Codable {
    let challenges: [ChallengeJson]
}

struct ChallengeJson: Codable {
    let Id: String
    let Category: String
    let Name: String
    let Description: String?
    let Like: String
    let NumberOfUser: String
    
}

class DataManager: ObservableObject {
    @Published var challenges: [ChallengeFB] = []
    @ObservedObject var challengeViewModel: ChallengeViewModel
    
    init(){
        self.challengeViewModel = ChallengeViewModel()
        fetchChallenges()
//        syncWithFirebase()
    }
    
    func syncWithFirebase(){
        print(challenges.count)
        if( challenges.count != 0) {
            // Sync with Firebase
            for challenge in challenges {
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
    
    
    
    func fetchChallenges() {
        challenges.removeAll()
        
        do {
           if let bundlePath = Bundle.main.path(forResource: "playdate-challenges", ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
               if let json = try? JSONDecoder().decode(ChallengesJson.self, from: jsonData) as? ChallengesJson {
                   let challengesJson: [ChallengeJson] = json.challenges
                   
                   for challenge in challengesJson {
                       self.challenges.append(
                        ChallengeFB(
                            name: challenge.Name,
                            description: challenge.Description ?? "",
                            category: challenge.Category,
                            id: challenge.Id,
                            like: Int(challenge.Like) ?? 0,
                            numberOfUser: Int(challenge.NumberOfUser) ?? 0
                        )
                       )
                   }
              } else {
                 print("Given JSON is not a valid dictionary object.")
              }
           }
        } catch {
           print(error)
        }
        
    }
}
