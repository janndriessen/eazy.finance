//
//  LaunchScreen.swift
//  eazy
//
//  Created by Jann Driessen on 28.06.21.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("eazy.finance 🕶")
                .font(.system(size: 44, design: .rounded).bold())
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
            .padding(.bottom, 8)
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
