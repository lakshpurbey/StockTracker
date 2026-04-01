//
//  Stock.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

struct Stock: Identifiable, Equatable {
    let id: String
    let symbol: String
    var price: Double
    var change: Double
}
