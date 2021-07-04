//
//  OnboardingCollateralView.swift
//  eazy
//
//  Created by Jann Driessen on 30.06.21.
//

import SwiftUI

struct OnboardingCollateralView: View {
    var amount: Int
    var collateral: Int

    @EnvironmentObject private var stateManager: OnboardingStateManager
    @State private var cardAdded = false
    @State private var isLoading = false
    @State private var isPresenting = false

    private let paymentsApi = PaymentsApi()
    private let cardsApi = CardsApi()

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                gradient: Gradient(colors: [EazyColor.highlight, EazyColor.highlight, EazyColor.title]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Supply")
                    .font(.system(size: 44, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                Text("Supply the stated amount via your preferred payment method to borrow $\(amount).")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                VStack {
                    Text("$\(collateral)")
                        .font(.system(size: 48, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal, 32)
                        .background(
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(EazyColor.text.opacity(0.6)))
                    Text("\(collateral) USDC")
                        .font(.system(size: 24, design: .rounded))
                        .foregroundColor(EazyColor.text)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 32)
                Spacer()
                EazyButton(title: cardAdded ? "Supply Collateral" : "Add Credit Card") {
                    if cardAdded {
                        paymentsApi.createPayment(amount: amount) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let success):
                                    if success {
                                        stateManager.next()
                                    }
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        }
                    } else {
                        isPresenting.toggle()
                    }
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                Text("Add another payment method")
                    .foregroundColor(.white)
                    .padding(16)
            }
            .padding()
        }
        .sheet(isPresented: $isPresenting, onDismiss: {
            self.cardAdded = true
        }, content: {
            NavigationView {
                AddCardView(cardsApi: cardsApi)
            }
        })
    }
}

struct OnboardingCollateralView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCollateralView(amount: 500, collateral: 750)
    }
}
