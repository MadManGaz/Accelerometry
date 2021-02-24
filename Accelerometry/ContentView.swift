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
    
#if DEBUG
    @State var address = "192.168.1.119:8765"
#else
    @State var address = ""
#endif
    
    @State private var isConnected = false
    
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
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .font(.system(size: 22, design: .monospaced))
            }
            .padding()
            
            Spacer()
            
            if isConnected {
                ModelView(quaternion: CMQuaternion())
                    .transition(.slide)
                    .animation(.easeInOut(duration: 1))
            }
            
            Spacer()
            
            // Passing in method references is probably a bad idea.
            // TODO: Find approach besides method references.
            StartStopButtons(accelerometerController: accelerometerController,
                             address: $address,
                             isConnected: $isConnected)
                .padding() 
        }
    }
}

struct CardBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(Color(UIColor.systemRed))
            .shadow(color: Color.red.opacity(0.6), radius: 5, x: 0.0, y: 0.0)
    }
}

/// Card view to display a label and coordinate
struct Coordinate: View {
    var label: String
    var singleCoord: Double
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.white)
                        .frame(width: 40, height: 30)
                    
                    Text(label)
                        .foregroundColor(.black)
                        .font(.headline)
                        .fontWeight(.bold)
                }
                Divider()
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color.white)
                        .frame(height: 30)
                    
                    Text("\(singleCoord)")
                        .foregroundColor(.black)
                        .font(.system(size: 14, design: .monospaced))
                }
            }
            .padding()
        }
    }
}

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

/// Buttons that execute passed in functions. Intended for pause/play functionality
struct StartStopButtons: View {
    @ObservedObject var accelerometerController: AccelerometerController
    @Binding var address: String
    @Binding var isConnected: Bool
    
    var body: some View {
        HStack {
            // TODO: Add validation for URL instead of force unwrapping
            Button(action: {
                self.accelerometerController.startUpdate(
                    url: URL(string: "ws://\(address)")!)
                isConnected = true
            }) {
                Image(systemName: "play")
                Text("Start")
            }
            
            Spacer()
            
            Button(action: {
                self.accelerometerController.endUpdate()
                isConnected = false
            }) {
                Text("End")
                Image(systemName: "pause")
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().previewDevice("iPhone 12 Pro Max")
        }
    }
}
