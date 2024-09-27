//
//  ListViewModelTests.swift
//  TravelVistaTests
//
//  Created by Benjamin LEFRANCOIS on 06/09/2024.
//

import XCTest
@testable import TravelVista

final class ListViewModelTests: XCTestCase {

    func test_GivenViewModelIsInstantiated_WhenGettingRegions_ThenRegionsExist() {
        // Given
        let viewModel = ListViewModel()
        // When
        let regions = viewModel.regions
        // Then
        XCTAssertEqual(regions.count, 5)
        XCTAssertTrue(regions.contains(where: { $0.name.lowercased() == "europe" }))
    }
}
