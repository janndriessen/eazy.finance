//
//  OnboardingTransactionView.swift
//  eazy
//
//  Created by Jann Driessen on 01.07.21.
//

import SwiftUI

struct OnboardingTransactionView: View {
    @EnvironmentObject private var appStateManager: AppStateManager

    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                gradient: Gradient(colors: [EazyColor.highlight, EazyColor.highlight, EazyColor.title]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            VStack {
                Text("💸")
                    .font(.system(size: 44, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                Text("We're sending a few transactions via the ethereum network to make your borrowed money available to you.\n\nThis might take a few minutes. We'll notify you when your money is ready.")
                    .font(.system(size: 24, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()
                EazyButton(title: "Got it!") {
                    withAnimation {
                        appStateManager.signedIn()
                    }
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
            }
            .padding()
        }
    }
}

struct OnboardingTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTransactionView()
    }
}
