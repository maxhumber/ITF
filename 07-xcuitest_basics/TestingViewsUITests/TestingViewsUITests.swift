import XCTest

/// Click-based functions
///
// tap()
// doubleTap()
// twoFingerTap()
// tap(withNumberOfTaps: UInt, numberOfTouches: UInt)
// press(forDuration: TimeInterval)
// press(forDuration: TimeInterval, thenDragTo: XCUIElement)

/// Generic UI interactions
///
// swipeLeft()
// swipeRight()
// swipeUp()
// swipeDown()
// pinch(withScale: CGFloat, velocity: CGFloat)
// rotate(CGFloat, withVelocity: CGFloat)

final class TestingViewsUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }
    
    func testCheckTheFlash() throws {
        let flash = app.staticTexts["The Flash"].exists
        XCTAssertTrue(flash)
    }

    func testRecordedInteractions() throws {
        // Press Record Here
        let collectionViewsQuery = XCUIApplication().collectionViews
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.swipeLeft()
        collectionViewsQuery.buttons["Delete"].tap()
        let arrow = app.staticTexts["Arrow"].exists
        XCTAssertFalse(arrow)
    }
    
    func testManualElements() throws {
        let identifier = "Star Button - Game of Thrones"
        let element = (
            app
                .descendants(matching: .any)
                .matching(NSPredicate(format: "identifier == '\(identifier)'"))
                .firstMatch
        )
        XCTAssertTrue(element.exists)
    }
}
