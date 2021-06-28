//
//  PayoutCompletedView.swift
//  eazy
//
//  Created by Jann Driessen on 28.06.21.
//

import SwiftUI

struct PayoutCompletedView: View {
    var didFinish: () -> Void
    @State private var isLoading = false

    var body: some View {
        ZStack(alignment: .top) {
            EazyColor.title.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Your money is on\nthe way to your\nbank account. 💸")
                    .font(.system(size: 44, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 32)
                Text("Give it 1-2 business days to show on your balance.")
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                EazyButton(title: "Got it", isLoading: isLoading) {
                    print("done")
                    didFinish()
                }
                .padding(.horizontal, 16)
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

struct PayoutCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        PayoutCompletedView {}
    }
}
