//
//  ListView.swift
//  TravelVista
//
//  Created by Benjamin LEFRANCOIS on 29/08/2024.
//

import SwiftUI

struct ListView: View {

    private let uiTesting_COUNTRY_ITEM_ID      = "COUNTRY_ITEM_ID"
    private let uiTesting_COUNTRY_NAME_ID      = "COUNTRY_NAME_ID"
    private let uiTesting_COUNTRY_CAPITAL_ID   = "COUNTRY_CAPITAL_ID"
    private let uiTesting_COUNTRY_RATE_ID      = "COUNTRY_RATE_ID"
    private let uiTesting_PINNED_HEADER_ID     = "PINNED_HEADER_ID"
    private let uiTesting_NOT_PINNED_HEADER_ID = "NOT_PINNED_HEADER_ID"
    private let listViewNavigationTitle        = "Liste de voyages"

    private let viewModel = ListViewModel()
    @State private var pinnedRegionName = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    ForEach(viewModel.regions, id: \.name) { region in
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
            .navigationTitle(listViewNavigationTitle)
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
//                            NavigationLink {
//                                DetailView(country: country)
//                            } label: {
//                                countryItem(for: country)
//                            }
//
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
            let isPinned = pinnedRegionName == regionName

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
                        .opacity(isPinned ? 1 : 0)
                )
                .accessibilityIdentifier(
                    isPinned ? uiTesting_PINNED_HEADER_ID : uiTesting_NOT_PINNED_HEADER_ID
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
            NavigationLink {
                DetailView(country: country)
                    .navigationTitle(country.name)
                    .navigationBarTitleDisplayMode(.inline)
            } label: {
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
            .accessibilityIdentifier(uiTesting_COUNTRY_ITEM_ID)
        }
    }
}

// MARK: Country item

private extension ListView {

    func countryItem(for country: Country) -> some View {
        HStack {
            Image(uiImage: UIImage(named: country.pictureName)!)
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
                    .accessibilityIdentifier(uiTesting_COUNTRY_NAME_ID)
                Text(country.capital)
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                    .frame(height: 20)
                    .padding(.bottom, 6)
                    .accessibilityIdentifier(uiTesting_COUNTRY_CAPITAL_ID)
            }
            .frame(height: 50)
            Spacer()
            Text("\(country.rate)")
                .font(.system(size: 17))
                .foregroundColor(.primary)
                .accessibilityIdentifier(uiTesting_COUNTRY_RATE_ID)
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
    ListView()
}
