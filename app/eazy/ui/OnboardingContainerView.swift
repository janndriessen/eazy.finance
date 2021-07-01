//
//  OnboardingContainerView.swift
//  eazy
//
//  Created by Jann Driessen on 01.07.21.
//

import SwiftUI

struct OnboardingContainerView: View {
    @StateObject private var stateManager = OnboardingStateManager()

    var body: some View {
        switch stateManager.onboardingState {
        case .start:
            StartScreen()
                .animation(.easeOut)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .environmentObject(stateManager)
        case .borrow:
            OnboardingBorrowView()
                .animation(.easeOut)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .environmentObject(stateManager)
        case .supply:
            OnboardingCollateralView()
                .animation(.easeOut)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .environmentObject(stateManager)
        }
    }
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContainerView()
    }
}

enum OnboardingState {
    case start
    case borrow
    case supply
}

final class OnboardingStateManager: ObservableObject {
    @Published var onboardingState: OnboardingState = .start

    init() {}

    func next() {
        switch onboardingState {
        case .start:
            showBorrow()
        case .borrow:
            showSupply()
        default:
            break
        }
    }
}

extension OnboardingStateManager {
    private func showBorrow() {
        withAnimation {
            onboardingState = .borrow
        }
    }

    private func showSupply() {
        withAnimation {
            onboardingState = .supply
        }
    }
}
