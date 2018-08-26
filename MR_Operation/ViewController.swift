//
//  ViewController.swift
//  MR_Operation
//
//  Created by 陳劭任 on 2018/8/25.
//  Copyright © 2018年 陳劭任. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Camera.truncateAll()
        Host.truncateAll()
        MagicalRecordManager.shared.save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func add(_ sender: UIButton) {
        
        let cameraEntity = MagicalRecordManager.shared.createEntity(entity: Camera.self) as! Camera
        
        cameraEntity.ip = "192.168.0.1"
        
        cameraEntity.account = "admin"
        
        cameraEntity.password = "qq"
        
        let hosts = MagicalRecordManager.shared.fetchEntitys(entity: Host.self, predicate: NSPredicate(format: "ip = %@", cameraEntity.ip!))
        
        if hosts.count > 0 {
           
            let host = hosts.first as! Host
            
            host.addToCameras(cameraEntity)
        }
        else {
            
            let hostEntity = MagicalRecordManager.shared.createEntity(entity: Host.self) as! Host
            
            hostEntity.addToCameras(cameraEntity)
            
            hostEntity.ip = cameraEntity.ip
            
        }

        MagicalRecordManager.shared.save()
        
    }
    
    @IBAction func remove(_ sender: UIButton) {
        
        let cameraEntitys = MagicalRecordManager.shared.fetchEntitys(entity: Camera.self, predicate: nil) as! [Camera]
        
        guard let camera = cameraEntitys.first else { return }
        
        camera.deleteEntity()
        
        if camera.host?.cameras?.count == 1 {
            
            camera.host?.deleteEntity()
            
        }
        
        MagicalRecordManager.shared.save()
        
    }
    
    @IBAction func update(_ sender: UIButton) {
        
        let cameraEntitys = MagicalRecordManager.shared.fetchEntitys(entity: Camera.self, predicate: nil) as! [Camera]
        
        guard let camera = cameraEntitys.first else { return }
        
        camera.password = "admin"
        
        MagicalRecordManager.shared.save()
        
    }
    
    @IBAction func fetch(_ sender: UIButton) {
        
        let hostEntitys = MagicalRecordManager.shared.fetchEntitys(entity: Host.self, predicate: NSPredicate(format: "ip = %@", "192.168.0.1")) as! [Host]
        
        guard let host = hostEntitys.first else { return }
        
        guard let cameras = host.cameras?.array as? [Camera] else { return }
        
        for camera in cameras {
            
            print("Camera is \(camera)")
            
        }
        
    }
    
}

