//
//  Camera+CoreDataProperties.swift
//  MR_Operation
//
//  Created by 陳劭任 on 2018/8/25.
//  Copyright © 2018年 陳劭任. All rights reserved.
//
//

import Foundation
import CoreData


extension Camera {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Camera> {
        return NSFetchRequest<Camera>(entityName: "Camera")
    }

    @NSManaged public var name: String?
    @NSManaged public var ip: String?
    @NSManaged public var account: String?
    @NSManaged public var password: String?
    @NSManaged public var index: Int16
    @NSManaged public var host: Host?

}
