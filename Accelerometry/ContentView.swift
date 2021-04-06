//
//  ContentView.swift
//  Accelerometry
//
//  Created by Gary Moore on 19/02/2021.
//

import SwiftUI
import CoreMotion
import os

let log = Logger()

struct ContentView: View {
    @ObservedObject private var accelerometerController = AccelerometerController()
    
    // Change this to your local address for convenient
    // debugging without the need for entering into the
    // text field every time.
    #if DEBUG
    @State var address = "192.168.1.119:8765"
    #else
    @State var address = ""
    #endif
    
    @State private var shouldConnect = false
    
    var body: some View {
        NavigationView {
            VStack {
                Coordinates(x: accelerometerController.x,
                            y: accelerometerController.y,
                            z: accelerometerController.z)
                    .padding()
                
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
                
                if shouldConnect {
                    ModelView()
                        .transition(.slide)
                        .animation(.easeInOut(duration: 1))
                }
                
                Spacer()
                
                ConnectionToggle(
                    address: $address,
                    shouldConnect: $shouldConnect,
                    accelerometerController: accelerometerController
                )
            }
            .navigationTitle("Accelerometry 📈")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12 Pro Max")
    }
}

struct ConnectionToggle: View {
    @Binding var address: String
    @Binding var shouldConnect: Bool
    @ObservedObject var accelerometerController: AccelerometerController
    
    var body: some View {
        Toggle("Connect", isOn: $shouldConnect)
            .onChange(of: shouldConnect, perform: { willConnect in
                if willConnect {
                    if let url = URL(string: "ws://\(address)") {
                        accelerometerController.startUpdate(url: url)
                    } else {
                        log.error("Malformed URL")
                    }
                } else {
                    accelerometerController.endUpdate()
                }
            })
            .padding()
    }
}
