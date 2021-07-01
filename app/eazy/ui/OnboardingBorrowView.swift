//
//  OnboardingBorrowView.swift
//  eazy
//
//  Created by Jann Driessen on 30.06.21.
//

import SwiftUI

struct OnboardingBorrowView: View {
    @EnvironmentObject private var stateManager: OnboardingStateManager
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
                Text("Enter an amount. Below you'll find how much you need to supply as collateral.")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                VStack {
                    Text("$0")
                        .font(.system(size: 48, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.horizontal, 32)
                        .background(
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(EazyColor.text.opacity(0.6)))
                    Text("Collateral: $1,000")
                        .bold()
                        .foregroundColor(.white)
                    HStack {
                        Text("$100")
                            .font(.system(size: 22, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(EazyColor.text.opacity(0.2)))
                        Text("$500")
                            .font(.system(size: 22, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(EazyColor.text.opacity(0.2)))
                        Text("$1,000")
                            .font(.system(size: 22, design: .rounded))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(EazyColor.text.opacity(0.2)))
                    }
                    .padding(.vertical, 8)
                }
                .padding(.top, 32)
                Spacer()
                EazyButton(title: "Supply Collateral") {
                    print("Send to ETH address")
                    stateManager.next()
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
