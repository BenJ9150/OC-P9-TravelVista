//
//  ListView.swift
//  TravelVista
//
//  Created by Benjamin LEFRANCOIS on 29/08/2024.
//

import SwiftUI

struct ListView: View {

    let regions: [Region]
    @State private var pinnedRegionName = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    ForEach(regions, id: \.name) { region in
                        Section {
                            countriesList(for: region)
                        } header: {
                            headerView(regionName: region.name)
                        }
                        Spacer()
                    }
                    .onAppear {
                        pinnedRegionName = ""
                    }
                }
                .coordinateSpace(.named("LazyVStack"))
                .padding(.vertical, 22)
            }
            .navigationTitle("Liste de voyages")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

//    // Simple version with List
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(regions, id: \.name) { region in
//                    Section {
//                        ForEach(region.countries, id: \.self) { country in
//                            countryItem(for: country)
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
}

// MARK: Header View

private extension ListView {
    
    func headerView(regionName: String) -> some View {
        GeometryReader { geo in
            Text(regionName)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color("TableViewHeader"))
                .bold()
                .padding(.leading)
                .frame(height: 28)
                .background(
                    Rectangle()
                        .fill(Material.bar)
                        .opacity(pinnedRegionName == regionName ? 1 : 0)
                )
                .onChange(of: geo.frame(in: .named("LazyVStack")).minY) { _, minY in
                    if abs(minY) == 0 {
                        pinnedRegionName = "" // no scroll, so no pinned header
                    } else {
                        // header is moving into LazyVStack, so is pinned
                        pinnedRegionName = regionName
                    }
                }
        }
        .frame(height: 28)
    }
}

// MARK: Countries list

private extension ListView {

    func countriesList(for region: Region) -> some View {
        ForEach(region.countries, id: \.self) { country in
            VStack(spacing: 0) {
                if country == region.countries.first {
                    Divider()
                        .padding(.leading)
                }
                countryItem(for: country)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                Divider()
                    .padding(.leading)
            }
            .frame(height: 65)
            .padding(.bottom, country == region.countries.last ? 14 : 0)
        }
    }
}

// MARK: Country item

private extension ListView {

    func countryItem(for country: Country) -> some View {
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
