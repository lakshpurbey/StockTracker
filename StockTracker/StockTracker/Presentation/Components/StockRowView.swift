//
//  StockRowView.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

import SwiftUI

struct StockRowView: View {
    
    let stock: Stock
    
    var body: some View {
        HStack(spacing: 12) {
            
            // Symbol
            Text(stock.symbol)
                .font(.headline)
                .frame(width: 70, alignment: .leading)
            
            Spacer()
            
            // Price
            Text(stock.price.toPriceString())
                .font(.subheadline)
                .frame(width: 80, alignment: .trailing)
            
            // Change
            Text(stock.change.toChangeString())
                .font(.subheadline)
                .foregroundColor(.stockChangeColor(stock.change))
                .frame(width: 80, alignment: .trailing)
        }
        .padding(.vertical, 8)
    }
}
