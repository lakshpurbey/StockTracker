//
//  WebSocketService.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

import Foundation

final class WebSocketService: WebSocketServiceProtocol {
    
    private var webSocketTask: URLSessionWebSocketTask?
    private let url = URL(string: "wss://ws.postman-echo.com/raw")!
    
    private var continuation: AsyncStream<ConnectionState>.Continuation?
    private var messageContinuation: AsyncStream<String>.Continuation?

    var connectionState: AsyncStream<ConnectionState> {
         AsyncStream { continuation in
             self.continuation = continuation
         }
     }
    
    
    var messages: AsyncStream<String> {
        AsyncStream { continuation in
            self.messageContinuation = continuation
        }
    }
    
    func connect() {
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        continuation?.yield(.connected) // LIVE
        receive()
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        continuation?.yield(.disconnected) // OFFLINE
    }
    
    func send(message: String) {
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print("Send error: \(error)")
            }
        }
    }
    
    private func receive() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(.string(let text)):
                self?.messageContinuation?.yield(text)
            case .failure(let error):
                print("Receive error: \(error)")
            default:
                break
            }
            self?.receive()
        }
    }
}
