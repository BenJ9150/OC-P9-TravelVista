//
//  DetailView.swift
//  TravelVista
//
//  Created by Benjamin LEFRANCOIS on 30/08/2024.
//

import SwiftUI

struct DetailView: UIViewControllerRepresentable {

    let country: Country

    func makeUIViewController(context: Context) -> DetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError()
        }
        detailVC.country = country
        return detailVC
    }
    
    func updateUIViewController(_ uiViewController: DetailViewController, context: Context) {}
}
