//
//  ContentView.swift
//  Accelerometry
//
//  Created by Gary Moore on 19/02/2021.
//

import SwiftUI
import CoreMotion


struct ContentView: View {
    @ObservedObject var accelerometerController = AccelerometerController()
    
    var body: some View {
        VStack {
            Text("Accelerometry")
                .font(.title)
                .padding()
            
            HStack {
                Text("\(accelerometerController.x)")
                Spacer()
                Text("\(accelerometerController.y)")
                Spacer()
                Text("\(accelerometerController.z)")
            }
            .padding()
            
            Spacer()
            
            HStack {
                Button(action: {self.accelerometerController.startUpdate()}) {
                    Image(systemName: "play")
                    Text("Start")
                }
                
                Spacer()
                
                Button(action: {self.accelerometerController.endUpdate()}) {
                    Text("End")
                    Image(systemName: "pause")
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
