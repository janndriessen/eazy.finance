//
//  Buttons.swift
//  eazy
//
//  Created by Jann Driessen on 28.06.21.
//

import SwiftUI

struct EazyButton: View {
    var title: LocalizedStringKey
    var isLoading = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: EazyColor.title))
            } else {
                Text(title)
            }
        }
        .buttonStyle(EazyButtonStyle())
    }
}

struct EazyDarkButton: View {
    var title: LocalizedStringKey
    var isLoading = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                Text(title)
            }
        }
        .buttonStyle(EazyDarkButtonStyle())
    }
}

struct EazyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.title2))
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.white)
            .foregroundColor(EazyColor.title)
            .clipShape(RoundedRectangle(cornerRadius: 15.0))
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeOut(duration: 0.2))
    }
}

struct EazyDarkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.title2))
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 56)
            .background(EazyColor.title)
//            .background(
//                LinearGradient(
//                    gradient: Gradient(colors: [EazyColor.highlight.opacity(0.8), EazyColor.highlight.opacity(0.8), EazyColor.highlight]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//            )
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15.0))
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeOut(duration: 0.2))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            EazyColor.title
            EazyButton(title: "hello", isLoading: false, action: {})
                .padding()
        }
    }
}
