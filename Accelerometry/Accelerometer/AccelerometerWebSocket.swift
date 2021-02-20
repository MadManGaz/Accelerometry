//
//  AccelerometerWebSocket.swift
//  Accelerometry
//
//  Created by Gary Moore on 19/02/2021.
//

import Foundation
import Starscream
import Combine
import os

class AccelerometerWebSocket: WebSocketDelegate {
    let logger = Logger()
    private var socket: WebSocket!
//    let server = WebSocketServer()
    
    var isConnected = false
    
    init(url: URL) {
        let request = URLRequest(url: url)
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    func write(_ string: String) {
        self.socket.write(string: string)
    }
    
    func writeSinkToServer(with publisher: AnyPublisher<(Double, Double, Double), Never>) {
        _ = publisher.sink(receiveValue: { coordinates in
            let (x, y, z) = coordinates
            let coordinateString = "Wrote \(x),\(y),\(z)"
            self.socket.write(string: coordinateString)
            self.logger.debug("\(coordinateString)")
        })
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
                case .connected(let headers):
                    isConnected = true
                    print("websocket is connected: \(headers)")
                case .disconnected(let reason, let code):
                    isConnected = false
                    print("websocket is disconnected: \(reason) with code: \(code)")
                case .text(let string):
                    if string == "disconnect" {
                        socket.disconnect()
                    } else {
                        print("ack")
                    }
                case .binary(let data):
                    print("Received data: \(data.count)")
                case .ping(_):
                    break
                case .pong(_):
                    break
                case .viabilityChanged(_):
                    break
                case .reconnectSuggested(_):
                    break
                case .cancelled:
                    isConnected = false
                case .error(let error):
                    isConnected = false
                    handleError(error)
                }
    }
    
    func handleError(_ error: Error?) {
            if let e = error as? WSError {
                print("websocket encountered an error: \(e.message)")
            } else if let e = error {
                print("websocket encountered an error: \(e.localizedDescription)")
            } else {
                print("websocket encountered an error")
            }
        }
}
