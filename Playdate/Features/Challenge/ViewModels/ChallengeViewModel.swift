//
//  ChallengeViewModel.swift
//  Playdate
//
//  Created by Alfine on 22/04/23.
//

import CoreData

class ChallengeViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var challenges: [Challenge] = []
    
    init() {
        getChallenges()
        self.challenges = challenges.shuffled()
//        self.challenges = Array(self.challenges[0..<3])
    }
    
    func getChallenges(){
        let req = NSFetchRequest<Challenge>(entityName: "Challenge")
        
        do {
            challenges = try manager.context.fetch(req)
        }catch let error {
            print("Error Fetching: \(error.localizedDescription)")
        }
    }
    
    func addChallenge(id: String, name: String, desc: String, like: Int, numberOfUser: Int, category: String){
        
        let newChallenge = Challenge(context: manager.context)
        
        newChallenge.id = id
        newChallenge.name = name
        newChallenge.desc = desc
        newChallenge.like = 0
        newChallenge.numberOfUser = 0
//        newChallenge.category = category
        save()
    }
    
    func clearChallenges() {
        //TODO: Clear Challenge buat ngesync ulang
    }
    
    func save(){
        manager.save()
    }
    
}
