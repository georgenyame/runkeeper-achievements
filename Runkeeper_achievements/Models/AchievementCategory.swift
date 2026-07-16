//
//  AchievementCategory.swift
//  Runkeeper_achievements
//
//  Created by George Nyame on 2026-07-15.
//

import Foundation

struct AchievementCategory: Codable, Equatable, Hashable {
    let id: String
    let displayName: String
    let sortOrder: Int
}

extension AchievementCategory {
    static let personalRecord = AchievementCategory(id: "personalRecord", displayName: "Personal Records", sortOrder: 0)
    static let virtualRace = AchievementCategory(id: "virtualRace", displayName: "Virtual Races", sortOrder: 1)
}
