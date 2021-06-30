//
//  AddCardView.swift
//  eazy
//
//  Created by Jann Driessen on 30.06.21.
//

import SwiftUI

struct AddCardView: View {
    @State private var isLoading = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .center) {
                HStack {
                    Text("Add Card")
                        .font(.system(size: 40, design: .rounded))
                        .foregroundColor(EazyColor.title)
                    Spacer()
                }
                CardView()
                Spacer()
                EazyDarkButton(title: "Add Credit Card", isLoading: isLoading) {
                    print("Send to ETH address")
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                Text("Cancel")
                    .foregroundColor(EazyColor.text)
                    .padding(16)
                    .padding(.bottom, 0)
            }
            .padding()
            .padding(.bottom, 0)
        }
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView()
    }
}

private struct CardView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [EazyColor.highlight, EazyColor.highlight, EazyColor.title]),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
            VStack(alignment: .leading) {
                Text("VISA")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Text("**** **** **** 3375")
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.white)
                    Spacer()
                        Text("01/22")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.white)
                }
            }
            .padding(25)
        }
        .frame(height: 220)
    }
}
