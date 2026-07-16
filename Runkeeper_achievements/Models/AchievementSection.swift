//
//  AchievementSection.swift
//  Runkeeper_achievements
//
//  View-layer grouping of achievements by category. Derived from a decoded
//  [Achievement] list, never decoded itself.
//

import Foundation

struct AchievementSection: Identifiable {
    let id: AchievementCategory
    let achievements: [Achievement]

    var title: String { id.displayName }
    var earnedCount: Int { achievements.filter(\.isEarned).count }
    var total: Int { achievements.count }

    /// The mock only shows a progress count when the section isn't fully earned.
    var showsProgressCount: Bool { earnedCount < total }
}

extension Array where Element == Achievement {
    /// Ordering comes entirely from each category's server-provided
    /// `sortOrder` — no client code here needs to know about specific
    /// category ids.
    func groupedIntoSections() -> [AchievementSection] {
        Dictionary(grouping: self, by: \.category)
            .map { category, achievements in
                AchievementSection(id: category, achievements: achievements)
            }
            .sorted { $0.id.sortOrder < $1.id.sortOrder || ($0.id.sortOrder == $1.id.sortOrder && $0.id.id < $1.id.id) }
    }
}
