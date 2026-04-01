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
    
    private var continuation: AsyncStream<String>.Continuation?
    
    var messages: AsyncStream<String> {
        AsyncStream { continuation in
            self.continuation = continuation
        }
    }
    
    func connect() {
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        receive()
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
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
                self?.continuation?.yield(text)
            case .failure(let error):
                print("Receive error: \(error)")
            default:
                break
            }
            self?.receive()
        }
    }
}
