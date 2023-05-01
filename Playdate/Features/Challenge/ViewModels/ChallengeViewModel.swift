//
//  ChallengeViewModel.swift
//  Playdate
//
//  Created by Alfine on 22/04/23.
//

import CoreData
import SwiftUI

class ChallengeViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    var challenges: [Challenge] = []
    @Published var capsuleIsClickedOnce = false
    
    @Published var filteredChallenges: [Challenge] = []
    @Published var displayedChallenges: [Int] = [0, 1, 2, 3, 4]
    @Published var lastDisplayIndex: Int = 4
    @Published var clickedCapsules: [String] = []
    
    init() {
        getChallenges()
        self.filteredChallenges = self.challenges.shuffled()
//        print("Filtered Challenges (count):", filteredChallenges.count)
    }
    
    func getChallenges(){
        let req = NSFetchRequest<Challenge>(entityName: "Challenge")
        
        do {
            self.challenges = try manager.context.fetch(req)
        }catch let error {
            print("Error Fetching: \(error.localizedDescription)")
        }
    }
    
    func addChallenge(id: String, name: String, desc: String, like: Int, numberOfUser: Int, category: String){
        
        let newChallenge = Challenge(context: manager.context)
        
        newChallenge.id = id
        newChallenge.name = name
        newChallenge.desc = desc
        newChallenge.like = Int64(like)
        newChallenge.numberOfUser = Int64(numberOfUser)
        newChallenge.category = category
        save()
    }
    
    func updateChallenge(id: String, name: String, desc: String, like: Int, numberOfUser: Int, category: String){
        if let index = challenges.firstIndex(where: { $0.id == id }){
            let c = challenges[index]
            c.id = id
            c.name = name
            c.desc = desc
            c.like = Int64(like)
            c.numberOfUser = Int64(numberOfUser)
            c.category = category
            print("index: \(index)")
        }else {
            addChallenge(id: id, name: name, desc: desc, like: Int(like), numberOfUser: Int(numberOfUser), category: category)
        }
    }
    
    func save() {
        manager.save()
    }
    
}
