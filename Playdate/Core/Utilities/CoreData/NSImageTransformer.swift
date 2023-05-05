//
//  NSImageTransformer.swift
//  Playdate
//
//  Created by Alfine on 05/05/23.
//

import Foundation
import UIKit

class NSImageTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return UIImage.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let image = value as? UIImage else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
            return data
        } catch {
            assertionFailure("Failed to transform `UIImage` to `Data`")
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? NSData else { return nil }
        
        do {
            let image = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data as Data)
            return image
        } catch {
            assertionFailure("Failed to transform `Data` to `UIImage`")
            return nil
        }
    }
}


extension NSImageTransformer {
    /// The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: NSImageTransformer.self))

    /// Registers the value transformer with `ValueTransformer`.
    public static func register() {
        let transformer = NSImageTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
