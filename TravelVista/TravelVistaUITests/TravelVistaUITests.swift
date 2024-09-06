//
//  TravelVistaUITests.swift
//  TravelVistaUITests
//
//  Created by Benjamin LEFRANCOIS on 06/09/2024.
//

import XCTest

final class TravelVistaUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        // Launch app before each test
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    // MARK: List of regions

    func test_ListOfRegions() throws {
        let app = XCUIApplication()

        XCTAssertTrue(app.staticTexts["Europe"].exists)
        XCTAssertTrue(app.staticTexts["Asie"].exists)
        XCTAssertTrue(app.staticTexts["Oceanie"].exists)
        XCTAssertTrue(app.staticTexts["Afrique"].exists)
        XCTAssertTrue(app.staticTexts["Ameriques"].exists)
    }

    // MARK: Open detail view

    func test_NavigationToDetailView() throws {
        let app = XCUIApplication()
        let listViewTitle = "Liste de voyages"
        let country = "Norvège"
        let capital = "Oslo"
        let rate = 4

        // Check navigation title of list view
        XCTAssertTrue(app.navigationBars[listViewTitle].staticTexts[listViewTitle].exists)
        
        // Clic on item to show detail view
        app.staticTexts[country].tap()

        // Check navigation title of detail view
        XCTAssertTrue(app.navigationBars[country].staticTexts[country].exists)
        
        // Check details in swiftUI hosting controller
        let stars = app.images.matching(identifier: "star")
        XCTAssertTrue(app.staticTexts[country].exists)
        XCTAssertTrue(app.staticTexts[capital].exists)
        XCTAssertEqual(stars.count, rate)
    }
}
