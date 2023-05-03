//
//  MemoryViewModel.swift
//  Playdate
//
//  Created by Alfine on 22/04/23.
//

import CoreData
import SwiftUI

class MemoryViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var memories: [Memory] = []
    
    init() {
        getMemories()
    }
    
    func getMemories(){
        let req = NSFetchRequest<Memory>(entityName: "Memory")
        
        do {
            memories = try manager.context.fetch(req)
        }catch let error {
            print("Error Fetching: \(error.localizedDescription)")
        }
    }
    
    func addMemory(challenge: Challenge){
        var dateComponent = DateComponents()
        dateComponent.day = 1

        let newMemory = Memory(context: manager.context)
        newMemory.id = UUID()
        newMemory.date = Calendar.current.date(byAdding: dateComponent, to: Date())
        newMemory.status = "ongoing"
        challenge.addToMemory(newMemory)
        
        save()
    }
    
    func submitMemory(photo: UIImage, description: String){
        if memories[memories.count-1].status == "ongoing"{
            memories[memories.count-1].photo = photo
            memories[memories.count-1].momentDescription = description
            save()
        }else{
            print("Error submiting memory")
        }
    }
    
    func removeMemory() {
        if memories[memories.count-1].status == "ongoing"{
            manager.context.delete(memories[memories.count-1])
            save()
        }
    }
    
    func removeAllMemories() {
        for m in memories {
            manager.context.delete(m)
            save()
        }
    }
    
    func checkChallengeCategoryColor(challengeCategory: String) -> Color {
        if challengeCategory.lowercased() == "travel" {
            return Color.primaryOrange
        } else if challengeCategory.lowercased() == "entertainment" {
            return Color.primaryPurple
        } else if challengeCategory.lowercased() == "food" {
            return Color.primaryRed
        } else if (challengeCategory.lowercased() == "well-being") {
            return Color.primaryGreen
        } else {
            return Color.gray
        }
    }
    
    func save(){
        manager.save()
    }
    
}
