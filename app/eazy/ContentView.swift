//
//  ContentView.swift
//  eazy
//
//  Created by Jann Driessen on 22.06.21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appStateManager = AppStateManager()

    var body: some View {
        switch appStateManager.appState {
        case .loading:
            StartScreen()
                .transition(.opacity)
                .onAppear {
                    showOnboarding()
                }
        case .main:
            DashboardView()
                .animation(.easeIn)
                .transition(.opacity)
                .environmentObject(appStateManager)
        case .onboarding:
            DashboardView()
                .animation(.easeIn)
                .transition(.opacity)
                .environmentObject(appStateManager)
        }
    }

    private func showOnboarding() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                self.appStateManager.appState = .onboarding
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
