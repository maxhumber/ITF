### ⭕️ ITF: iOS Testing Fundamentals



00 - **Introduction** (10 minutes) [T+0:10]

```
Slides
```

- Goals: Legible, Maintainable, Replaceable
- “FIRST” Principles
- “Red, Green, Rector” Cycles
- Demo: Application



01 - **Getting Started with XCTest** (20 minutes) [T+0:30]

```
Basics
FizzBuzz
```

- Test Driven Development
- XCTestCase Anatomy
- Arrange, Act, Assert
- Common “Asserts”
- Exercise: Write a few simple unit tests!
- Q&A



02 - **Testing Asynchronous Code** (20 minutes) [T+0:50]

```
Pretend this is SDK code we don't own...
Old completion code to hit network
```

- New Structured Concurrency (async/await)
- Using “Task” to run async code
- Wrapping “old” completion handler code
- Exercise: Write a unit test to cover a “completion handler upgrade”
- Q&A



**Break** (5 minutes) [T+0:55]



03 - **Protocols and “Code Replaceability”** (20 minutes) [T+1:15]

```
ArrayLiteral
CaseIterable
Custom
Matchable
```

- Protocol Conformance
- “Constrain” & “Gain”
- Common and Useful Protocols

- Inheritance, Composition, Extension
- Exercise: Improve code legibility/replaceability with a Protocol
- Q&A



04 - **Networking!** (15 minutes) [T+1:30]

```
Extensions (Stringify)
Codable
```

- “REPL-DD”
- API calls with URLSession
- Parsing JSON with the Codable Protocol
- Handling/Propagating Errors
- Exercise: Make some async/await API calls!   
- Q&A



05 - **Test Doubles and Network Mocking** (15 minutes) [T+1:45]

- Fixtures, Fakes, Stubs, Mocks
- Mocking with Protocols
- Mocking Network Layers (for isolation and to reduce “flakiness”)
- Exercise: Create some networking unit tests
- Q&A



**Break** (5 minutes) [T+1:50]



06 - **SwiftUI Basics** (25 minutes) [T+2:15]

- Text, Image, SF Symbols
- (V, H, Z) Stacks
- Adaptive Sizing
- Standard Components (Button, Toggle, Stepper, Slider, etc.) 
- Common ViewModifiers
- @State, @Binding
- Bridging UIKit (UIHostingController, UIViewRepresentable)
- Exercise: Translate a wireframe into a SwiftUI layout
- Q&A



07 - **Testing Views with XCUITest** (20 minutes) [T+2:35]

- Setting initial states
- Finding elements to test
- Simulating user interaction
- Recording tests
- Exercise: Write some UI tests for a View
- Q&A



08 - **MVVM and “Code Organization”** (20 minutes) [T+2:55]

- ObservableObject + @Published
- @EnvironmentObject + @StateObject + @ObservedObject
- Managing Access Control
- Code Separation/Modularization
- Folder Structure and Organization
- Exercise: Extract out a ViewModel from a View and write some tests for it
- Q&A


**Conclusion** (5 minutes) [T+3:00]



----

