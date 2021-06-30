//
//  PayoutView.swift
//  eazy
//
//  Created by Jann Driessen on 28.06.21.
//

import SwiftUI

struct PayoutView: View {
    @Environment(\.presentationMode) private var presentationMode
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
                NavigationLink(destination: PayoutCompletedView {
                    presentationMode.wrappedValue.dismiss()
                }, isActive: $isLinkActive) {}
                Text("Your loan is ready\nto be paid out.")
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
                EazyButton(title: "Send to ETH address") {
                    print("Send to ETH address")
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                EazyButton(title: "Send to bank account", isLoading: isLoading) {
                    payout()
                }
                .padding(.horizontal, 16)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }

    private func payout() {
        print("Send to bank account")
        self.isLoading.toggle()
        payoutsApi.payout(amount: "1000") {
            isLinkActive = true
        }
    }
}

struct PayoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PayoutView()
        }
    }
}
