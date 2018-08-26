//
//  MagicalRecordManager.swift
//  MR_Operation
//
//  Created by 陳劭任 on 2018/8/26.
//  Copyright © 2018年 陳劭任. All rights reserved.
//

import Foundation
import MagicalRecord

private let _manager = MagicalRecordManager()

class MagicalRecordManager: NSObject {
    
    private var moc: NSManagedObjectContext!
    
    open class var shared: MagicalRecordManager {
        
        return _manager
        
    }
    
    override init() {
        
        super.init()
        
        let magicalStack = MagicalRecord.setupAutoMigratingStack(withSQLiteStoreNamed: "MagicalRecord.sqlite")
        
        moc = magicalStack!.context
        
    }

    func createEntity(entity: NSManagedObject.Type) -> NSManagedObject {
        
        let managedObject = entity.mr_createEntity(in: self.moc)
        
        return managedObject
    }
    
    func fetchEntitys(entity: NSManagedObject.Type, predicate: NSPredicate?) -> [NSManagedObject] {
        
        let results = entity.mr_findAll(with: predicate)
    
        return results as! [NSManagedObject]
        
    }
    
    func save() {
        
        moc.mr_saveToPersistentStoreAndWait()
        
    }

}

