//
//  OnboardingBorrowView.swift
//  eazy
//
//  Created by Jann Driessen on 30.06.21.
//

import SwiftUI

struct OnboardingBorrowView: View {
    @State private var isLoading = false
    @State private var isLinkActive = false

    private var payoutsApi = PayoutsApi()

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                gradient: Gradient(colors: [EazyColor.highlight, EazyColor.highlight, EazyColor.title]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            VStack {
                Text("How much do you wanna borrow?")
                    .font(.system(size: 44, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                Text("Select your preferred way of receiving it.")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                VStack {
                    Text("$1,000")
                        .font(.system(size: 48, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal, 32)
                        .background(
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(EazyColor.text.opacity(0.6)))
                    Text("1,000 USDC")
                        .font(.system(size: 24, design: .rounded))
                        .foregroundColor(EazyColor.text)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 32)
                Spacer()
                EazyButton(title: "Supply Collateral") {
                    print("Send to ETH address")
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                Text("Don't wanna borrow, I wanna earn!")
                    .foregroundColor(.white)
                .padding(16)
            }
            .padding()
        }
    }

    private func payout() {
        print("Send to bank account")
        self.isLoading.toggle()
        payoutsApi.payout(amount: "1000") {
            isLinkActive = true
        }
    }
}

struct OnboardingBorrowView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingBorrowView()
    }
}
