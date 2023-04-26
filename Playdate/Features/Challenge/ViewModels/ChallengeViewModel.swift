//
//  ChallengeViewModel.swift
//  Playdate
//
//  Created by Alfine on 22/04/23.
//

import CoreData

class ChallengeViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    var challenges: [Challenge] = []
    @Published var capsuleIsClickedOnce = false
    @Published var filteredChallenges: [Challenge] = []
    @Published var clickedCategories: [String] = []
    
    init() {
        getChallenges()
        print(challenges)
        self.filteredChallenges = self.challenges.shuffled()
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
        
//        newChallenge.id = Int64(id)
        newChallenge.id = id
        newChallenge.name = name
        newChallenge.desc = desc
        newChallenge.like = 0
        newChallenge.numberOfUser = 0
        newChallenge.category = category
        save()
    }
    
    func clearChallenges() {
        //TODO: Clear Challenge buat ngesync ulang
//        if challenges.count != 0 {
//            for index in 0...challenges.count {
//                let challenge = challenges[index]
//                manager.context.delete(challenge)
//            }
//            
//            save()
//        }
    }
    
    func save(){
        manager.save()
    }
    
}
