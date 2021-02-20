//
//  CMMotionManagerSingleton.swift
//  Accelerometry
//
//  Created by Gary Moore on 20/02/2021.
//

import Foundation
import CoreMotion

class CMMotionManagerSingleton {
    static var motionManager: CMMotionManager = {
        let shared = CMMotionManager()
        return shared
    }()
    
    private init() {}
}
