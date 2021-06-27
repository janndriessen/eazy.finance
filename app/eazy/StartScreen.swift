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
                .font(.system(size: 46, design: .rounded).bold())
                .padding()
            Spacer()
            Text("Powered by")
                .padding(.bottom, 8)
            HStack {
                Image("compound-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
                Image("circle-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 36)
            }
        }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
