//
//  Favorites+CoreDataProperties.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/31.
//  Copyright © 2019 xgf. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var collectDate: Date?
    @NSManaged public var createdAt: String?
    @NSManaged public var desc: String?
    @NSManaged public var id: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var source: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?
    @NSManaged public var used: Bool
    @NSManaged public var who: String?
    @NSManaged public var images: String?

}
