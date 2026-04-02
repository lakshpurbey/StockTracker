//
//  WebSocketServiceProtocol.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

enum ConnectionState {
    case connected
    case disconnected
}

protocol WebSocketServiceProtocol {
    func connect()
    func disconnect()
    func send(message: String)
    var messages: AsyncStream<String> { get }
    var connectionState: AsyncStream<ConnectionState> { get }
}
