//
//  Color+Theme.swift
//  Runkeeper_achievements
//
//  Reusable theme colors matching the medal case mock's hex/annotations.
//

import SwiftUI

extension Color {
    /// Primary brand/accent background — nav bar.
    static let primaryColor = Color(hex: 0x63C6D4)
    /// Text/foreground rendered on top of `primaryColor`.
    static let primaryTextColor = Color(hex: 0xFFFFFF)

    /// Secondary background — section header bar.
    static let secondaryColor = Color(hex: 0xF7F7F7)
    /// Text rendered on top of `secondaryColor`.
    static let secondaryTextColor = Color(hex: 0x666666)

    /// Achievement title.
    static let tertiaryColor = Color(hex: 0x333333)
    /// Achievement subtitle/time.
    static let tertiaryTextColor = Color(hex: 0x000000)
}

private extension Color {
    init(hex: UInt32) {
        let red = Double((hex & 0xFF0000) >> 16) / 255
        let green = Double((hex & 0x00FF00) >> 8) / 255
        let blue = Double(hex & 0x0000FF) / 255
        self.init(red: red, green: green, blue: blue)
    }
}
