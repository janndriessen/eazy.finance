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
                .environmentObject(stateManager)
        case .borrow:
            OnboardingBorrowView()
                .animation(.easeOut)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .environmentObject(stateManager)
        case .supply:
            OnboardingCollateralView(amount: stateManager.borrowAmount, collateral: stateManager.collateral)
                .animation(.easeOut)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                .environmentObject(stateManager)
        case .transaction:
            OnboardingTransactionView()
                .animation(.easeIn)
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
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
    case transaction
}

final class OnboardingStateManager: ObservableObject {
    @Published var onboardingState: OnboardingState = .start
    var borrowAmount: Int = 0
    var collateral: Int = 0

    init() {}

    func next() {
        switch onboardingState {
        case .start:
            showBorrow()
        case .supply:
            showTransaction()
        default:
            break
        }
    }

    func showSupply(for borrowAmount: Int, collateral: Int) {
        self.borrowAmount = borrowAmount
        self.collateral = collateral
        withAnimation {
            onboardingState = .supply
        }
    }
}

extension OnboardingStateManager {
    private func showBorrow() {
        withAnimation {
            onboardingState = .borrow
        }
    }

    private func showTransaction() {
        withAnimation {
            onboardingState = .transaction
        }
    }
}
