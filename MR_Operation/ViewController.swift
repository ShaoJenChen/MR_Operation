//
//  ViewController.swift
//  MR_Operation
//
//  Created by 陳劭任 on 2018/8/25.
//  Copyright © 2018年 陳劭任. All rights reserved.
//

import UIKit
import CoreData

enum DeviceType {
    case host
    case camera
}

class Device {
    
    var type: DeviceType
    
    var ip: String
    
    var index: Int
    
    init(type: DeviceType, ip: String, index: Int) {
        
        self.type = type
        
        self.ip = ip
        
        self.index = index
        
    }
    
    func getDevice() -> NSManagedObject {
        switch type {
        case .host:
            let hosts = MagicalRecordManager.shared.fetchEntitys(entity: Host.self, predicate: NSPredicate(format: "ip == %@", self.ip))
            let host = hosts.first
            
            return host!
            
        case .camera:
            let hosts = MagicalRecordManager.shared.fetchEntitys(entity: Host.self, predicate: NSPredicate(format: "ip == %@", self.ip))
            
            let host = hosts.first as! Host
            
            let camera = host.cameras![self.index] as! Camera
            
            return camera
        }
    }
    
}

class ViewController: UIViewController {

    var devices = [Device]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Camera.truncateAll()
        Host.truncateAll()
        MagicalRecordManager.shared.save()
        
        //prepare devices
        let hosts = MagicalRecordManager.shared.fetchEntitys(entity: Host.self, predicate: nil) as! [Host]
        
        for host in hosts {
            
            if host.cameras!.count > 1 {
                
                let device = Device(type: .host, ip: host.ip!, index: 0)
                
                self.devices.append(device)
                
                let cameras = host.cameras?.array as! [Camera]
                
                for camera in cameras {
                    
                    let device = Device(type:.camera, ip: camera.ip!, index: Int(camera.index))
                    
                    self.devices.append(device)
                    
                }
                
            }
            else {
                
                let device = Device(type:.host, ip: host.ip!, index: 0)
                
                self.devices.append(device)
                
            }
            
        }
        
        //get device
        let type = self.devices[0].type
        switch type{
        case .camera:
            let device = self.devices[0].getDevice() as! Camera
        case .host:
            let device = self.devices[0].getDevice() as! Host
        }
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

