//
//  AccelerometerWebSocket.swift
//  Accelerometry
//
//  Created by Gary Moore on 19/02/2021.
//

import Foundation
import Starscream
import os

class AccelerometerWebSocket: WebSocketDelegate {
    let logger = Logger()
    private var socket: WebSocket!
    
    var isConnected = false
    
    init(url: URL) {
        let request = URLRequest(url: url)
        socket = WebSocket(request: request)
        socket.delegate = self
    }
    
    
    func connect() {
        isConnected
            ? logger.notice("WebSocket already connected.")
            : socket.connect()
    }
    
    func disconnect() {
        isConnected
            ? socket.disconnect()
            : logger.notice("WebSocket already disconnected.")
        
        logger.info("WebSocket disconnected")
    }
    
    func write(_ string: String) {
        self.socket.write(string: string)
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
                case .connected(let headers):
                    isConnected = true
                    print("websocket is connected: \(headers)")
                case .disconnected(let reason, let code):
                    isConnected = false
                    print("websocket is disconnected: \(reason) with code: \(code)")
                case .text(_):
                    break
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
