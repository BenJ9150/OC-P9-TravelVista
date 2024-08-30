//
//  ListView.swift
//  TravelVista
//
//  Created by Benjamin LEFRANCOIS on 29/08/2024.
//

import SwiftUI

struct ListView: View {

    @State private var scrollOffset: CGFloat = 0
    let regions: [Region]

    // Simple version with List
    
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(regions, id: \.name) { region in
//                    Section {
//                        ForEach(region.countries, id: \.self) { country in
//                            countryRaw(for: country)
//                        }
//                    } header: {
//                        Text(region.name)
//                            .bold()
//                    }
//                }
//            }
//            .navigationTitle("Liste de voyages")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//    }

    // Version with LazyVStack and pinned headers

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    ForEach(regions, id: \.name) { region in
                        Section {
                            ForEach(region.countries, id: \.self) { country in
                                VStack(spacing: 0) {
                                    if country == region.countries.first {
                                        Divider()
                                            .padding(.leading)
                                    }
                                    countryRaw(for: country)
                                        .padding(.horizontal)
                                        .padding(.vertical, 6)
                                    Divider()
                                        .padding(.leading)
                                }
                                .frame(height: 65)
                                .padding(.bottom, country == region.countries.last ? 22 : 0)
                            }
                        } header: {
                            Text(region.name)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color("TableViewHeader"))
                                .bold()
                                .padding(.leading)
                                .frame(height: 28)
                                .background(Color(.systemBackground))
                        }
                    }
                }
            }
            .navigationTitle("Liste de voyages")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: country raw

private extension ListView {

    func countryRaw(for country: Country) -> some View {
        HStack {
            Image(uiImage: UIImage(named: country.pictureName) ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: 52, height: 52)
                .mask { Circle() }
                .padding(.leading, 4)
            VStack(spacing: 0) {
                Text(country.name)
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color("CustomBlue"))
                    .frame(height: 24)
                Text(country.capital)
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 20)
                    .padding(.bottom, 6)
            }
            .frame(height: 50)
            Spacer()
            Text("\(country.rate)")
                .font(.system(size: 17))
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .padding(.all, 2)
                .frame(width: 32, height: 32)
                .foregroundStyle(.accent)
                .padding(.trailing, 4)
        }
    }
}

// MARK: - Preview

#Preview {
    ListView(regions: Service().load("Source.json"))
}
