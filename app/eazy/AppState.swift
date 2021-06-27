//
//  AppState.swift
//  eazy
//
//  Created by Jann Driessen on 27.06.21.
//

import Foundation

enum AppState {
    case loading
    case main
    case onboarding
}

class AppStateManager: ObservableObject {
    @Published var appState: AppState = .loading

    init() {}

    func startOnboarding() {
        appState = .onboarding
    }

    func signedIn() {
        appState = .main
    }
}
