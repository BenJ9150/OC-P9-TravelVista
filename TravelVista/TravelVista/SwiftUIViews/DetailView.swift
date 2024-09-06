//
//  DetailView.swift
//  TravelVista
//
//  Created by Benjamin LEFRANCOIS on 30/08/2024.
//

import SwiftUI

struct DetailView: UIViewControllerRepresentable {

    let storyboardId = "DetailViewController"
    let country: Country

    func makeUIViewController(context: Context) -> DetailViewController {
        guard let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: storyboardId) as? DetailViewController else {
            fatalError()
        }
        detailVC.country = country
        return detailVC
    }
    
    func updateUIViewController(_ uiViewController: DetailViewController, context: Context) {}
}
