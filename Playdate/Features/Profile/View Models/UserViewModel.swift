//
//  MemoryViewModel.swift
//  Playdate
//
//  Created by Alfine on 22/04/23.
//

import CoreData

class UserViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    
    @Published var user: [User] = []
    
    init() {
        getUsers()
        print("\nUsers count: \(user.count)")
    }
    
    func getUsers() {
        let req = NSFetchRequest<User>(entityName: "User")
        
        do {
            user = try manager.context.fetch(req)
        }catch let error {
            print("Error Fetching: \(error.localizedDescription)")
        }
    }
    
    func addUser(name: String) {
        let newUser = User(context: manager.context)
        newUser.id = UUID()
        newUser.name = name
        
        save()
    }
    
    func removeUser(name: String) {
        for u in user {
            if u.name == name {
                manager.context.delete(u)
                save()
            }
        }
    }
    
    func save() {
        manager.save()
    }
    
}
