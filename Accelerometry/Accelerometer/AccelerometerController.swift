//
//  AccelerometerController.swift
//  Accelerometry
//
//  Created by Gary Moore on 19/02/2021.
//

import Foundation
import CoreMotion
import os

class AccelerometerController: ObservableObject {
    let logger = Logger()
    
    private let motionManager = CMMotionManagerSingleton.motionManager
    
    private var webSocket = AccelerometerWebSocket(url: URL(string: "ws://192.168.1.119:8765")!)
    
    @Published private(set) var x = 0.0
    @Published private(set) var y = 0.0
    @Published private(set) var z = 0.0
    
    private(set) var coordinates = (x: 0.0, y: 0.0, z: 0.0) {
        didSet {
            if webSocket.isConnected {
                let (x, y, z) = coordinates
                webSocket.write("\(x),\(y),\(z)")
            }
        }
    }
    
    func startUpdate() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1.0 / 60.0
            motionManager.startAccelerometerUpdates()
            logger.info("Did start accelerometer updates")
            
            motionManager.startAccelerometerUpdates(to: .main) { (accelerometerData, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                
                if let accelData = accelerometerData {
                    self.x = accelData.acceleration.x
                    self.y = accelData.acceleration.y
                    self.z = accelData.acceleration.z
                    self.coordinates = (self.x, self.y, self.z)
                }
            }
            
            webSocket.connect()
        }
    }
    
    func endUpdate() {
        motionManager.stopAccelerometerUpdates()
        logger.info("Did stop accelerometer updates")
        webSocket.disconnect()
    }
}
