//
//  ServiceTests.swift
//  TravelVistaTests
//
//  Created by Benjamin LEFRANCOIS on 06/09/2024.
//

import XCTest
@testable import TravelVista

final class ServiceTests: XCTestCase {

    func test_GivenThereAreJsonData_WhenLoadingData_ThenAnArrayOfRegionsExist() {
        // Given
        let jsonDataFileName = "Source.json"
        // When
        let regions = Service().load(jsonDataFileName) as [Region]
        // Then
        XCTAssertEqual(regions.count, 5)
        XCTAssertTrue(regions.contains(where: { $0.name.lowercased() == "europe" }))
    }
}
