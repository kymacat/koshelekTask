//
//  Image+CoreDataClass.swift
//  KoshelekTask
//
//  Created by Const. on 24.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Image)
public class Image: NSManagedObject {

}

extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: Constants.CoreData.Entities.imageEntityName)
    }

    @NSManaged public var url: String?
    @NSManaged public var image: Data?
    @NSManaged public var isliked: Bool
    @NSManaged public var breed: Breed?

}
