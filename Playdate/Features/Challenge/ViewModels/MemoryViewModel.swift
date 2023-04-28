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
    
    func removeMemory() {
        if memories[memories.count-1].status == "ongoing"{
            manager.context.delete(memories[memories.count-1])
            save()
            print("inside")
            print(memories)
        }
    }
    
    func checkChallengeCategoryColor(memory: Memory) -> Color {
        if memory.challenge?.category?.lowercased() == "travel" {
            return Color.primaryPurple
        } else if memory.challenge?.category?.lowercased() == "entertainment" {
            return Color.primaryGreen
        } else if memory.challenge?.category?.lowercased() == "sport" {
            return Color.primaryRed
        } else if (memory.challenge?.category?.lowercased() == "wellbeing" || memory.challenge?.category?.lowercased() == "well-being") { // di core data belum "well-being" !
            return Color.primaryOrange
        } else {
            return Color.pink
        }
    }
    
//    func addMemory(momentDescription: String, photoURL: String){
//
//        newMemory.momentDescription = momentDescription
//        newMemory.photoURL = photoURL
//
//        save()
//    }
    
    func save(){
        manager.save()
    }
    
}
