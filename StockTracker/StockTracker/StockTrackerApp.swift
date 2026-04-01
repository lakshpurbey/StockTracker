//
//  StockTrackerApp.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

import SwiftUI

@main
struct StockTrackerApp: App {
    
    let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            StockListView(
                viewModel: container.makeStockListViewModel()
                )
        }
    }
}
