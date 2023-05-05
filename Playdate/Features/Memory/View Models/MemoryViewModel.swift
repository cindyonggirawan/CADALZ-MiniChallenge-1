//
//  MemoryViewModel.swift
//  Playdate
//
//  Created by Alfine on 22/04/23.
//

import CoreData
import SwiftUI
import UIKit
import WidgetKit

class MemoryViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var memories: [Memory] = []
    @Published var filteredMemories: [Memory] = []
    @Published var x: Int = 100
    
    @Published var memoriesId: [UUID] = []
    @Published var capsuleIsClickedOnce = false
    @Published var clickedCapsules: [String] = []

    init() {
        getMemories()
        if self.memories.count == 0 {
            bijibijian()
        }
        
        getMemories()
        print("\nMemories count: \(memories.count)")
        self.filteredMemories = self.memories
    }
    
    func getMemories(){
        let req = NSFetchRequest<Memory>(entityName: "Memory")
        
        do {
            memories = try manager.context.fetch(req)
        }catch let error {
            print("Error Fetching: \(error.localizedDescription)")
        }
    }
    
    func getChallenges() -> [Challenge] {
        let req = NSFetchRequest<Challenge>(entityName: "Challenge")
        var results: [Challenge] = []
        
        do {
            results = try manager.context.fetch(req)
        }catch let error {
            print("Error Fetching: \(error.localizedDescription)")
        }
        
        return results
    }
    
    func addMemory(challenge: Challenge, user: User){
        var dateComponent = DateComponents()
        dateComponent.day = 1

        let newMemory = Memory(context: manager.context)
        newMemory.id = UUID()
        newMemory.date = Calendar.current.date(byAdding: dateComponent, to: Date())
        newMemory.status = "ongoing"

        challenge.addToMemory(newMemory)
        user.addToMemory(newMemory)
        
        save()
    }
    
    func addMemory2(challenge: Challenge){

        let newMemory = Memory(context: manager.context)
        newMemory.id = UUID()
        newMemory.date = Date()
        newMemory.status = "ongoing"
        
        if let img = UIImage(named: challenge.category!.lowercased()) {
            newMemory.photo = img
        } else {
            print("UIImage NIL")
        }
        
        challenge.addToMemory(newMemory)
    
        
        save()
    }
    
    func submitMemory(photo: UIImage, description: String){
        if memories[memories.count-1].status == "ongoing"{
            let memory = memories[memories.count-1]
            memory.photo = photo
            memory.momentDescription = description
            memory.status = "completed"
            memory.date = Date()
            save()
            
            if memories.count == 1 {
                WidgetCenter.shared.reloadAllTimelines()
            }
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
    
    func appendMemoryUUID(_ id: UUID) -> Void { // BUAT BULK-DELETE PHOTO. LEWAT UUID NYA, HAPUS MEMORIES
        if let idx = self.memoriesId.firstIndex(of: id) {
            self.memoriesId.remove(at: idx)
        } else {
            self.memoriesId.append(id)
        }
    }
    
    func deleteMemoryPhotos() -> Void {
        print("\nAWAL")
        printMemoriesNyaChallenge()
        
        for memoryUuid in memoriesId {
            for memory in memories { // Memory (CoreData)
                if let id = memory.id { // unwrapping
                    if id == memoryUuid { // id => id nya memory CoreData!
                         // FORCE-UNWRAP KARENA PASTI GAK NULL
                        manager.context.delete(memory)
                        break
                    }
                }
            }
        }
        
        save()
        
        print("\nAKHIR")
        printMemoriesNyaChallenge()
        
        print("\n")
    }
    
    // ========================= FUNCS FOR DEBUGGING!!!!!!!!
    func ngeprint() -> Void {
        for mem in memories {
            if let photo = mem.photo {
                print(photo)
                print("===\n")
            }
        }
    }
    
    func bijibijian() -> Void {
        for chl in getChallenges() {
            if let category = chl.category {
                if category == "Food" {
                    for _ in 0..<3 {
                        addMemory2(challenge: chl)
                    }
                    break
                }
                
            }
        }
        
        for chl in getChallenges() {
            if let category = chl.category {
                if category == "Travel" {
                    for _ in 0..<4 {
                        addMemory2(challenge: chl)
                    }
                    break
                }
                
            }
        }
        
        for chl in getChallenges() {
            if let category = chl.category {
                if category == "Well-being" {
                    for _ in 0..<5 {
                        addMemory2(challenge: chl)
                    }
                    break
                }
                
            }
        }
    }

    func printMemoriesNyaChallenge() -> Void {
        let challenges: [Challenge] = self.getChallenges()
        
        print("\nPRINTING JUMLAH MEMORY PADA SETIAP CHALLENGE")
        for chl in challenges {
            if
                let category = chl.category,
                let memory = chl.memory
            {
                print("Category: \(category). Memories: \(memory.count)")
            } else {
                print("CATEGORY / MEMORY IS NIL")
            }
        }
    }
    
    func tambahSatu() -> Void {
        x += 1
    }
    
    func filterMemories(category: String) -> Void {
        self.memories = self.memories.filter({ memory in
            if let chl = memory.challenge {
                return chl.category! == category
            }
            return false // IF CHALLENGE IS NULL
        })
    }
}
