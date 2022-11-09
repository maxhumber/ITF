### ⭕️ ITF: iOS Testing Fundamentals



✅ 00 - **Introduction** (15 minutes)

```
Slides
```

- Goals: Legible, Maintainable, Replaceable
- Test Driven Development
- “FIRST” Principles
- “Red, Green, Rector” Cycles
- Demo: Application



✅ 01 - **Getting Started with XCTest** (25 minutes)

```
Basics
FizzBuzz
```

- XCTestCase Anatomy
- Arrange, Act, Assert
- Common “Asserts”
- Exercise: Write a few simple unit tests!



✅ 02 - **Testing Asynchronous Code** (10 minutes)

```
Pretend this is SDK code we don't own...
Old completion code to hit network
Stringify
```

- New Structured Concurrency (async/await)
- Using “Task” to run async code
- Wrapping “old” completion handler code
- Exercise: Write a unit test to cover a “completion handler upgrade”



✅  03 - **Protocols and “Code Replaceability”** (20 minutes)

> Detour!

```
Equatable
Identifiable
ArrayLiteral
DictionaryLiteral
Matchable
```

- Protocol Conformance
- “Constrain” & “Gain”
- Common and Useful Protocols

- Inheritance, Composition, Extension
- Exercise: Improve code legibility/replaceability with a Protocol



✅  04 - **Networking!** (15 minutes) 

```
Extensions (Stringify)
Codable
```

- “REPL-DD”
- API calls with URLSession
- Parsing JSON with the Codable Protocol
- Handling/Propagating Errors
- Exercise: Make some async/await API calls!   



1/2 | 05 - **Test Doubles and Network Mocking** (15 minutes)

```
Service Architecture
```

- Fixtures, Fakes, Stubs, Mocks
- Mocking with Protocols
- Mocking Network Layers (for isolation and to reduce “flakiness”)
- Exercise: Create some networking unit tests



1/2 | 06 - **SwiftUI Basics** (25 minutes)

- Text, Image, SF Symbols
- (V, H, Z) Stacks
- Adaptive Sizing
  - Geometry Reader, padding, Spacer(), .frame(alignment)

- Standard Components (Button, Toggle, Stepper, Slider, etc.) 
- Common ViewModifiers
  - font
  - foregroundColor

- @State, @Binding
- Bridging UIKit (UIHostingController, UIViewRepresentable)
- Exercise: Translate a wireframe into a SwiftUI layout



07 - **Testing Views with XCUITest** (20 minutes)

- Setting initial states
- Finding elements to test
- Simulating user interaction
- Recording tests
- Exercise: Write some UI tests for a View



1/2 | 08 - **MVVM and “Code Organization”** (20 minutes)

- ObservableObject + @Published
- @EnvironmentObject + @StateObject + @ObservedObject
- Managing Access Control
- Code Separation/Modularization
- Folder Structure and Organization
- Exercise: Extract out a ViewModel from a View and write some tests for it



**Conclusion** (5 minutes)
