//
//  AccelerometerController.swift
//  Accelerometry
//
//  Created by Gary Moore on 19/02/2021.
//

import Foundation
import CoreMotion
import Combine
import os

class AccelerometerController: ObservableObject {
    let logger = Logger()
    
    private let subject = PassthroughSubject<(Double, Double, Double), Never>()
    var publisher: AnyPublisher<(Double, Double, Double), Never> {
        return subject.eraseToAnyPublisher()
    }
    
    private let motionManager = CMMotionManagerSingleton.motionManager
    private var timer = Timer()
    
    private var webSocket = AccelerometerWebSocket(url: URL(string: "ws://192.168.1.119:8765")!)
    
    @Published private(set) var x = 0.0
    @Published private(set) var y = 0.0
    @Published private(set) var z = 0.0
    
    private(set) var coordinates = (x: 0.0, y: 0.0, z: 0.0) {
        didSet {
            let (x, y, z) = coordinates
            webSocket.write("\(x),\(y),\(z)")
        }
    }
    
    func startUpdate() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 1.0 / 60.0
            motionManager.startAccelerometerUpdates()
            logger.info("Did start accelerometer updates")
            
            self.timer = Timer(fire: Date(), interval: (1.0 / 60.0), repeats: true) { timer in
                if let data = self.motionManager.accelerometerData {
                    self.x = data.acceleration.x
                    self.y = data.acceleration.y
                    self.z = data.acceleration.z
                    self.coordinates = (self.x, self.y, self.z)
                }
            }
            
            RunLoop.current.add(self.timer, forMode: .default)
            webSocket.write("Test message")
//            webSocket.writeSinkToServer(with: publisher)
        }
    }
    
    func endUpdate() {
        motionManager.stopAccelerometerUpdates()
        logger.info("Did stop accelerometer updates")
        timer.invalidate()
    }
}
