//
//  TravelVistaUITests.swift
//  TravelVistaUITests
//
//  Created by Benjamin LEFRANCOIS on 06/09/2024.
//

import XCTest

final class TravelVistaUITests: XCTestCase {

    private let uiTesting_COUNTRY_ITEM_ID      = "COUNTRY_ITEM_ID"
    private let uiTesting_COUNTRY_NAME_ID      = "COUNTRY_NAME_ID"
    private let uiTesting_COUNTRY_CAPITAL_ID   = "COUNTRY_CAPITAL_ID"
    private let uiTesting_COUNTRY_RATE_ID      = "COUNTRY_RATE_ID"
    private let uiTesting_PINNED_HEADER_ID     = "PINNED_HEADER_ID"
    private let uiTesting_NOT_PINNED_HEADER_ID = "NOT_PINNED_HEADER_ID"
    private let uiTesting_STAR_ID              = "STAR_ID"
    private let listViewNavigationTitle        = "Liste de voyages"

    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }

    // MARK: Open detail view

    func test_NavigationToDetailView() throws {
        // Check if list view is showed
        XCTAssertTrue(app.navigationBars[listViewNavigationTitle].exists)

        // Get first item of first countries list
        let firstCountryItem = app.buttons[uiTesting_COUNTRY_ITEM_ID].firstMatch
        XCTAssertTrue(firstCountryItem.exists)
        
        // Get country name, capital and rate element
        let countryNameElement = firstCountryItem.staticTexts[uiTesting_COUNTRY_NAME_ID].firstMatch
        let countryCapitalElement = firstCountryItem.staticTexts[uiTesting_COUNTRY_CAPITAL_ID].firstMatch
        let countryRateElement = firstCountryItem.staticTexts[uiTesting_COUNTRY_RATE_ID].firstMatch
        XCTAssertTrue(countryNameElement.exists)
        XCTAssertTrue(countryCapitalElement.exists)
        XCTAssertTrue(countryRateElement.exists)
        
        // Get label of elements
        let countryName = countryNameElement.label
        let countryCapital = countryCapitalElement.label
        let countryRate = Int(countryRateElement.label)
        
        // Clic on item to show detail view and check if navigation title has changed
        firstCountryItem.tap()
        XCTAssertTrue(app.navigationBars[countryName].exists)
        
        // Check details in swiftUI hosting controller of detail view
        let starsInDetailView = app.images.matching(identifier: uiTesting_STAR_ID)
        XCTAssertTrue(app.staticTexts[countryName].exists)
        XCTAssertTrue(app.staticTexts[countryCapital].exists)
        XCTAssertEqual(starsInDetailView.count, countryRate)
    }

    // MARK: Pinned header after scrolling

    func test_OneHeaderIsPinnedAfterScrolling() {
        // Check if there is no pinned header before scrolling
        XCTAssertFalse(app.staticTexts[uiTesting_PINNED_HEADER_ID].exists)
        XCTAssertTrue(app.staticTexts[uiTesting_NOT_PINNED_HEADER_ID].exists)
        
        // Scroll
        app.scrollViews.firstMatch.swipeUp()
        
        // Check if there pinned header after scrolling
        XCTAssertTrue(app.staticTexts[uiTesting_PINNED_HEADER_ID].exists)
    }
}
