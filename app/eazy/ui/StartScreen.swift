//
//  StartScreen.swift
//  eazy
//
//  Created by Jann Driessen on 27.06.21.
//

import SwiftUI

struct StartScreen: View {
    var body: some View {
        VStack {
            Spacer()
            Text("eazy.finance 🕶")
                .font(.system(size: 44, design: .rounded).bold())
                .padding()
                .padding(.top, -64)
            Text("Borrowing/earning money is easy with eazy.finance")
                .font(.system(.title, design: .rounded))
                .multilineTextAlignment(.center)
            Spacer()
            Text("Just supply money and start earning or borrowing.")
                .font(.system(.subheadline, design: .rounded))
                .multilineTextAlignment(.center)
            EazyDarkButton(title: "Start now")  {
                print("start")
            }
            .padding()
        }
        .padding()
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
