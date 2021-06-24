//
//  EazyColors.swift
//  eazy
//
//  Created by Jann Driessen on 24.06.21.
//

import Foundation
import SwiftUI

enum EazyColor {
    static let background = Color(hex: 0xFFFFFF)
    static let borrow = Color(hex: 0x8BB3B3)
    static let element = Color(hex: 0xF0F5F9)
    static let headline = Color(hex: 0x2B2E33)
    static let highlight = Color(hex: 0x331084)
    static let pending = Color(hex: 0xDCC521)
    static let text = Color(hex: 0x647694)
    static let title = Color(hex: 0x10042A)
}

enum EazyGradient {
    static let borrow = Gradient(colors: [EazyColor.borrow.opacity(0.4), EazyColor.borrow.opacity(0.6)])
    static let element = Gradient(colors: [EazyColor.element.opacity(0.6), EazyColor.element])
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
