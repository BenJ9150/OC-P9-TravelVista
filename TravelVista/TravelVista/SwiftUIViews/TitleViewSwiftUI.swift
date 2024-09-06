//
//  TitleViewSwiftUI.swift
//  TravelVista
//
//  Created by Benjamin LEFRANCOIS on 29/08/2024.
//

import SwiftUI

struct TitleViewSwiftUI: View {

    let country: String
    let capital: String
    let rate: Int
    let height: CGFloat

    var body: some View {
        HStack {
            countryAndCapital
            Spacer()
            stars
        }
        .frame(height: height)
    }
}

// MARK: Country

private extension TitleViewSwiftUI {

    var countryAndCapital: some View {
        VStack(spacing: 0) {
            Text(country)
                .font(.system(size: 22, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color("CustomBlue"))
                .frame(height: 28)
            Text(capital)
                .font(.system(size: 17))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color(.darkGray))
                .frame(height: 21)
        }
        .padding(.leading, 20)
    }
}

// MARK: Rate

private extension TitleViewSwiftUI {

    var stars: some View {
        HStack(spacing: 0) {
            ForEach(0..<rate, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .padding(.all, 1)
                    .frame(width: 19, height: 19)
                    .foregroundStyle(.accent)
                    .accessibilityIdentifier("star")
            }
        }
        .padding(.trailing, 16)
    }
}

// MARK: - Preview

#Preview {
    TitleViewSwiftUI(country: "Vietnam", capital: "Hanoi", rate: 4, height: 65)
}
