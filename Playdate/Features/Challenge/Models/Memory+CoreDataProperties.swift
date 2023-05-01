//
//  Memory+CoreDataProperties.swift
//  Playdate
//
//  Created by Alfine on 01/05/23.
//
//

import Foundation
import CoreData
import UIKit


extension Memory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memory> {
        return NSFetchRequest<Memory>(entityName: "Memory")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var momentDescription: String?
    @NSManaged public var photo: UIImage?
    @NSManaged public var status: String?
    @NSManaged public var challenge: Challenge?
    @NSManaged public var user: User?

}

extension Memory : Identifiable {

}
