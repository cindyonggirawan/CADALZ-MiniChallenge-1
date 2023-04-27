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
    
    func updateChallenge(id: String, name: String, desc: String, like: Int, numberOfUser: Int, category: String){
        if let index = challenges.firstIndex(where: { $0.id == id }){
            let c = challenges[index]
            c.id = id
            c.name = name
            c.desc = desc
            c.like = 0
            c.numberOfUser = 0
            c.category = category
            print("index: \(index)")
        }else {
            addChallenge(id: id, name: name, desc: desc, like: like, numberOfUser: numberOfUser, category: category)
        }
    }
    
    func save(){
        manager.save()
    }
    
}
