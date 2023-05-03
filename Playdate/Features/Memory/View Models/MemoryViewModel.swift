//
//  MemoryViewModel.swift
//  Playdate
//
//  Created by Alfine on 22/04/23.
//

import CoreData
import SwiftUI
import UIKit

class MemoryViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var memories: [Memory] = []
    @Published var rows: Int = 0
    var photoIdx: Int = -1
	
    init() {
        
        getMemories()
        if self.memories.count == 0 {
            for chl in getChallenges() {
                addMemory2(challenge: chl)
            }
        }
        
        getMemories()
        print("\nMemories count \(memories.count)")
        
        rows = Int(ceil(Double(self.memories.count) / 3.0))
    }
    
    func renderPhoto() -> AnyView {
        if self.photoIdx < self.memories.count - 1 {
            self.photoIdx += 1
        }
        
        if let photo = self.memories[self.photoIdx].photo {
            return AnyView(
                VStack {
                    Image(uiImage: photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 116, height: 118)
//                    Text(self.memories[self.photoIdx].challenge?.category! ?? "asdasd")
                }
            )
        }
        return AnyView(EmptyView())
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
    
    func addMemory2(challenge: Challenge){

        let newMemory = Memory(context: manager.context)
        newMemory.id = UUID()
        newMemory.date = Date()
        newMemory.status = "ongoing"
        
        if let img = UIImage(named: challenge.category!.lowercased()) {
            newMemory.photo = img
        } else {
            print("waduhhh UIImage")
        }
        
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
    
    func ngeprint() -> Void {
        for mem in memories {
            if let photo = mem.photo {
                print(photo)
                print("===\n")
            }
        }
    }
    
}
