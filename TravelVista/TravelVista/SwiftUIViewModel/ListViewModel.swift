//
//  ListViewModel.swift
//  TravelVista
//
//  Created by Benjamin LEFRANCOIS on 30/08/2024.
//

import SwiftUI

class ListViewModel: ObservableObject {

    @Published var regions: [Region] = []

    init() {
        regions = Service().load("Source.json")
    }
}
