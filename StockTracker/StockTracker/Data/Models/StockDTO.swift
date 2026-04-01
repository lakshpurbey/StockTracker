//
//  StockDTO.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

import Foundation

struct StockDTO: Codable {
    let symbol: String
    let price: Double
}

// MARK:  -  Mapping  -

extension StockDTO {
    
    func toDomain(previousPrice: Double = 0) -> Stock {
        let change = price - previousPrice
        
        return Stock(
            id: symbol,
            symbol: symbol,
            price: price,
            change: change
        )
    }
}
