//
//  StartScreen.swift
//  eazy
//
//  Created by Jann Driessen on 27.06.21.
//

import SwiftUI

struct StartScreen: View {
    @EnvironmentObject private var stateManager: OnboardingStateManager

    var body: some View {
        VStack {
            LinearGradient(
                gradient: Gradient(colors: [EazyColor.highlight, .white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, 128)
            VStack(alignment: .leading) {
                Text("eazy.finance 🕶")
                    .font(.system(size: 44, design: .rounded).bold())
                    .foregroundColor(EazyColor.title)
                    .padding(.top, -64)
                Text("Borrowing and earning is easy with us. Supply money now and get started.")
                    .font(.system(.title, design: .rounded))
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 32)
                EazyDarkButton(title: "Start Now")  {
                    print("start")
                    stateManager.next()
                }
                .padding(.vertical)
            }
            .padding()
        }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
