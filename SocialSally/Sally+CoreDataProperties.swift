//
//  Sally+CoreDataProperties.swift
//  SocialSally
//
//  Created by Eddie Gear on 16/09/21.
//
//

import Foundation
import CoreData


extension Sally {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sally> {
        return NSFetchRequest<Sally>(entityName: "Sally")
    }

    @NSManaged public var authorHandle: String?
    @NSManaged public var authorName: String?
    @NSManaged public var authorNote: String?
   // @NSManaged public var timestamp: Date?
    @NSManaged public var hashtags: String?
  //  @NSManaged public var authorImage: Data?
    @NSManaged public var linkedinValue: Bool
    @NSManaged public var twitterValue: Bool
 //   @NSManaged public var linkedinBadge: Data?
  //  @NSManaged public var twitterBadge: Data?

}

extension Sally : Identifiable {

}
