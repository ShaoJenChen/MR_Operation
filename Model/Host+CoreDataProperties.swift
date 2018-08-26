//
//  Host+CoreDataProperties.swift
//  MR_Operation
//
//  Created by 陳劭任 on 2018/8/25.
//  Copyright © 2018年 陳劭任. All rights reserved.
//
//

import Foundation
import CoreData


extension Host {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Host> {
        return NSFetchRequest<Host>(entityName: "Host")
    }

    @NSManaged public var ip: String?
    @NSManaged public var account: String?
    @NSManaged public var password: String?
    @NSManaged public var cameras: NSOrderedSet?

}

// MARK: Generated accessors for cameras
extension Host {

    @objc(insertObject:inCamerasAtIndex:)
    @NSManaged public func insertIntoCameras(_ value: Camera, at idx: Int)

    @objc(removeObjectFromCamerasAtIndex:)
    @NSManaged public func removeFromCameras(at idx: Int)

    @objc(insertCameras:atIndexes:)
    @NSManaged public func insertIntoCameras(_ values: [Camera], at indexes: NSIndexSet)

    @objc(removeCamerasAtIndexes:)
    @NSManaged public func removeFromCameras(at indexes: NSIndexSet)

    @objc(replaceObjectInCamerasAtIndex:withObject:)
    @NSManaged public func replaceCameras(at idx: Int, with value: Camera)

    @objc(replaceCamerasAtIndexes:withCameras:)
    @NSManaged public func replaceCameras(at indexes: NSIndexSet, with values: [Camera])

    @objc(addCamerasObject:)
    @NSManaged public func addToCameras(_ value: Camera)

    @objc(removeCamerasObject:)
    @NSManaged public func removeFromCameras(_ value: Camera)

    @objc(addCameras:)
    @NSManaged public func addToCameras(_ values: NSOrderedSet)

    @objc(removeCameras:)
    @NSManaged public func removeFromCameras(_ values: NSOrderedSet)

}
