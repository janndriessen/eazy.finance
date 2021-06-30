//
//  OnboardingCollateralView.swift
//  eazy
//
//  Created by Jann Driessen on 30.06.21.
//

import SwiftUI

struct OnboardingCollateralView: View {
    @State private var cardAdded = false
    @State private var isLoading = false

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
                Text("Supply the stated amount via your preferred payment method to borrow $1,000.")
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
                EazyButton(title: "Add Credit Card") {
                    print("Send to ETH address")
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                Text("Add another payment method")
                    .foregroundColor(.white)
                    .padding(16)
            }
            .padding()
        }
    }
}

struct OnboardingCollateralView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCollateralView()
    }
}
