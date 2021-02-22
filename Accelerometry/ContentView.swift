//
//  ContentView.swift
//  Accelerometry
//
//  Created by Gary Moore on 19/02/2021.
//

import SwiftUI
import CoreMotion


struct ContentView: View {
    @ObservedObject private var accelerometerController = AccelerometerController()
    @State private var address: String = ""
    
    var body: some View {
        VStack {
            Text("Accelerometry 📈")
                .font(.title)
                .padding()
              
            Coordinates(x: accelerometerController.x,
                        y: accelerometerController.y,
                        z: accelerometerController.z)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Enter IP address and port")
                    .font(.caption)
                TextField("localhost:8765", text: $address)
                    .font(.system(size: 22, design: .monospaced))
            }
            .padding()
            
            Spacer()
            
            Button("Print to screen") {
                print("This does something")
            }
            
            // Passing in method references is probably a bad idea.
            // TODO: Find approach besides method references.
            StartStopButtons(start: accelerometerController.startUpdate,
                             end: accelerometerController.endUpdate)
        }
    }
}

struct CardBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(Color(UIColor.systemBackground))
            .shadow(color: Color(UIColor.systemFill), radius: 5, x: 0.0, y: 0.0)
    }
}

/// Card view to display a label and coordinate
struct Coordinate: View {
    var label: String
    var singleCoord: Double
    
    var body: some View {
        ZStack {
            CardBackground()
            
            VStack {
                Text(label)
                    .font(.headline)
                Divider()
                Text("\(singleCoord)")
                    .font(.system(size: 14, design: .monospaced))
                    .frame(width: 100, height: 25)
            }
        }
    }
}

/// View to display x, y, z coordinates in individual cards.
struct Coordinates: View {
    let x: Double
    let y: Double
    let z: Double
    
    var body: some View {
        HStack {
            Coordinate(label: "x", singleCoord: x)
            Spacer()
            Coordinate(label: "y", singleCoord: y)
            Spacer()
            Coordinate(label: "z", singleCoord: z)
        }
        .padding(20)
        .multilineTextAlignment(.center)
        .frame(height: 120)
    }
}

struct StartStopButtons: View {
    let start: () -> Void
    let end: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {start()}) {
                Image(systemName: "play")
                Text("Start")
            }
            
            Spacer()
            
            Button(action: {end()}) {
                Text("End")
                Image(systemName: "pause")
            }
        }
        .padding()
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
