//
//  AddCardView.swift
//  eazy
//
//  Created by Jann Driessen on 30.06.21.
//

import SwiftUI

struct AddCardView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var isLoading = false
    @ObservedObject private var cardsApi = CardsApi()

    var body: some View {
        let card = cardsApi.cards.first
        return (
            ZStack(alignment: .topLeading) {
                VStack(alignment: .center) {
                    HStack {
                        Text("Add Card")
                            .font(.system(size: 40, design: .rounded))
                            .foregroundColor(EazyColor.title)
                        Spacer()
                    }
                    .padding(.top, 32)
                    CardView(
                        cardType: card?.cardType ?? "",
                        number: card?.number ?? "",
                        expires: card?.expires ?? "")
                    Spacer()
                    EazyDarkButton(title: "Add Credit Card", isLoading: isLoading) {
                        presentationMode.wrappedValue.dismiss()
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
            .navigationBarHidden(true)
            .onAppear {
                let payload = CardsApi.CreateCardPayload.sathoshisVisa
                cardsApi.createCard(payload: payload)
            }
        )
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView()
    }
}

private struct CardView: View {
    var cardType: String
    var number: String
    var expires: String

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
                Text(cardType.uppercased())
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Text(number)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.white)
                    Spacer()
                        Text(expires)
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.white)
                }
            }
            .padding(25)
        }
        .frame(height: 220)
    }
}
