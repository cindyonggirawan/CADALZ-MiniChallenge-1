//
//  MemoryViewModel.swift
//  Playdate
//
//  Created by Alfine on 22/04/23.
//

import CoreData

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
    
    func addMemory(momentDescription: String, photoURL: String){
        
        let newMemory = Memory(context: manager.context)
        newMemory.id = UUID()
        newMemory.date = Date()
        newMemory.momentDescription = momentDescription
        newMemory.photoURL = photoURL
        newMemory.status = "ongoing"
        //TODO: CONNECT KE RELATION
//        newMemory.challenge =
//        newMemory.user =
        
        save()
    }
    
    func save(){
        manager.save()
    }
    
}
