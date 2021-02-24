//
//  CoordView.swift
//  Accelerometry
//
//  Created by Gary Moore on 22/02/2021.
//

import SwiftUI
import SceneKit
import CoreMotion

struct ModelView: View {
    @Environment(\.colorScheme) private var colorScheme
    private let scene = SCNScene(named: "Robot.scn")
    var quaternion: CMQuaternion
    
    var body: some View {
        SceneView(scene: scene,
                  options: [.autoenablesDefaultLighting,
                            .temporalAntialiasingEnabled,
                            .allowsCameraControl])
    }
}

// You must turn on live preview to see 3D model.
struct CoordView_Previews: PreviewProvider {
    static var previews: some View {
        ModelView(quaternion: CMQuaternion())
    }
}
