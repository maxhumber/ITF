import XCTest

final class TestingViewsUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testExample2() throws {
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 3).swipeDown()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element.swipeLeft()
        collectionViewsQuery.buttons["Delete"].tap()
        
        let image = collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .image).element(boundBy: 1)
        image.tap()
        image.tap()
        
    }
}
