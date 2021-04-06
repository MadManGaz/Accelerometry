//
//  CoordView.swift
//  Accelerometry
//
//  Created by Gary Moore on 22/02/2021.
//

import SwiftUI
import SceneKit
import CoreMotion

struct ModelView: View, Equatable {
    private let scene = SCNScene(named: "Robot.scn")
    var body: some View {
        SceneView(scene: scene,
                  options: [.autoenablesDefaultLighting,
                            .temporalAntialiasingEnabled,
                            .allowsCameraControl])
    }
    
    static func == (lhs: ModelView, rhs: ModelView) -> Bool {
        return true
    }
}

// You must turn on live preview to see 3D model.
struct CoordView_Previews: PreviewProvider {
    static var previews: some View {
        ModelView()
    }
}
