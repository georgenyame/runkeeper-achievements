//
//  Achievement.swift
//  Runkeeper_achievements
//

import Foundation

struct Achievement: Identifiable, Codable, Equatable {
    let id: String
    let category: AchievementCategory
    let title: String
    let subtitle: String
    let imageName: String
    let isEarned: Bool
}
