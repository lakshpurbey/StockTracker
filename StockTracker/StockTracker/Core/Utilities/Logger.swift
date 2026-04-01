//
//  Logger.swift
//  StockTracker
//
//  Created by Laksh Purbey on 01/04/26.
//

// MARK:  -  Logger  -

import Foundation

enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case error = "ERROR"
}

// MARK:  -  Logger  -

struct Logger {
    
    static func log(
        _ message: String,
        level: LogLevel = .debug,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
#if DEBUG
        let fileName = (file as NSString).lastPathComponent
        
        print("""
        [\(level.rawValue)] 📍\(fileName):\(line) \(function)
        ➤ \(message)
        """)
#endif
    }
}
