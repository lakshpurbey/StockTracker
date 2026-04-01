//
//  Extension.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

import Foundation
import SwiftUI

// MARK:  -  Double + Formatting  -

extension Double {
    
    func toPriceString() -> String {
        String(format: "%.2f", self)
    }
    
    func toChangeString() -> String {
        let prefix = self >= 0 ? "+" : ""
        return "\(prefix)\(String(format: "%.2f", self))"
    }
}

// MARK:  -  Color + Stock Change  -

extension Color {
    
    static func stockChangeColor(_ value: Double) -> Color {
        value >= 0 ? .green : .red
    }
}
