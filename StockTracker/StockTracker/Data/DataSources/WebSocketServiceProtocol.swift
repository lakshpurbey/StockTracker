//
//  WebSocketServiceProtocol.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

protocol WebSocketServiceProtocol {
    func connect()
    func disconnect()
    func send(message: String)
    var messages: AsyncStream<String> { get }
}
