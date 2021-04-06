//
//  Coordinates.swift
//  Accelerometry
//
//  Created by Gary Moore on 27/02/2021.
//

import SwiftUI

/// View to display x, y, z coordinates in individual cards.
struct Coordinates: View {
    let x: Double
    let y: Double
    let z: Double
    
    var body: some View {
        ZStack {
            CardBackground()
            
            HStack {
                Coordinate(label: "x", singleCoord: x)
                Coordinate(label: "y", singleCoord: y)
                Coordinate(label: "z", singleCoord: z)
            }
        }
        .padding()
        .frame(height: 120)
    }
}

struct Coordinates_Previews: PreviewProvider {
    static var previews: some View {
        Coordinates(x: 0.0, y: 0.0, z: 0.0)
            .previewLayout(.sizeThatFits)
    }
}
