//
//  Coordinate.swift
//  Accelerometry
//
//  Created by Gary Moore on 27/02/2021.
//

import SwiftUI

/// Card view to display a label and coordinate
struct Coordinate: View {
    var label: String
    var singleCoord: Double
    
    var body: some View {
        VStack {
            ZStack {
                // Label background
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                    .frame(width: 40, height: 30)
                
                // Label
                Text(label)
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            Divider()
            ZStack {
                // Number background
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                    .frame(height: 30)
                
                // Number
                Text("\(singleCoord)")
                    .foregroundColor(.black)
                    .font(.system(size: 14, design: .monospaced))
            }
        }
        .padding()
    }
}

struct Coordinate_Previews: PreviewProvider {
    static var previews: some View {
        Coordinate(label: "X", singleCoord: 0.0)
            .previewLayout(.sizeThatFits)
    }
}
