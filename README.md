# StockTracker

Real-Time Stock Price Tracker (iOS)
A production-grade iOS application built using SwiftUI + Clean Architecture + MVVM, designed to simulate real-time stock price updates using WebSocket communication.

Features: 
Real-time stock price updates (25+ symbols)
WebSocket-based live data simulation

Symbol list with sorting:
  - Sort by Price
  - Sort by Price Change

Detailed stock screen with live updates
Connection status indicator (Live / Offline)
Start / Stop price feed control
Modern, production-level UI with SwiftUI
Unit-tested architecture with async stream validation

Architecture
This project follows Clean Architecture with MVVM, ensuring scalability, testability, and separation of concerns.

Presentation (SwiftUI)
    ↓
ViewModel (State Management)
    ↓
Domain (UseCases + Protocols)
    ↓
Data (Repositories + WebSocket)
    ↓
Core (Networking, DI, Utilities)

Key Principles :
✅ Single Source of Truth
✅ Dependency Injection
✅ Protocol-Oriented Programming
✅ SOLID Principles
✅ Reactive Data Flow using AsyncStream

📁 Project Structure
StockTrackerApp/
├── App/
├── Core/
│   ├── Networking/
│   ├── DI/
│   └── Utilities/
├── Domain/
├── Data/
├── Presentation/
├── Resources/
└── Tests/

🔌 Real-Time Data Flow

WebSocket connects to:
wss://ws.postman-echo.com/raw
App sends random price updates

Echo server returns the message
Repository updates stock prices
UI reacts instantly via AsyncStream

🧠 Key Technical Decisions

Why Clean Architecture?
Decouples business logic from UI
Enables scalability for future features (API, caching, offline mode)

Improves testability
Why AsyncStream instead of Combine?
Lightweight and modern Swift concurrency
Easier async/await integration
Better readability for streaming data

Why Repository Pattern?
Abstracts data source (WebSocket today, REST tomorrow)
Makes mocking easy for tests

🧪 Testing Strategy
The project includes unit tests with clear goals and async validation.
Covered Areas

✅ Repository:
Stream emissions
Connection state handling

✅ ViewModels:
Sorting logic
State transitions (Start / Stop)

✅ Detail Screen:
Real-time stock updates
Connection status updates

Testing Approach
Mocked WebSocket layer
AsyncStream testing using XCTestExpectation
Isolation of business logic via protocols

▶️ How to Run
Clone the repository
Open .xcodeproj in Xcode
Run on simulator or device
Tap Start to begin live updates

🧩 Scalability Considerations
This architecture is designed to scale:

 - Replace WebSocket with real stock API
 - Add local caching (CoreData / Realm)
 - Multi-region backend support
 - Add charts (Swift Charts)
 - Auto-reconnect with retry policies

🎨 UI Highlights
 - Card-based layout for detail screen
 - Animated price updates
 - Visual indicators for price change
 - Live connection status with real-time updates

🔮 Future Improvements
 - Historical price charts
 - Price alerts / notifications
 - Offline mode with sync
 - Secure WebSocket handling
 - Performance optimizations (diffing, batching updates)

👨‍💻 Author
Developed as part of an iOS technical assessment focusing on architecture, real-time data handling, and production-quality code.
