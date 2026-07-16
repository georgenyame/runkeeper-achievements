//
//  AchievementsGridView.swift
//  Runkeeper_achievements
//

import SwiftUI

struct AchievementsGridView: View {
    let sections: [AchievementSection]

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: .spacingZero) {
                ForEach(sections) { section in
                    Section {
                        ForEach(section.achievements) { achievement in
                            AchievementView(achievement: achievement)
                        }
                    } header: {
                        AchievementSectionHeaderView(section: section)
                            .gridCellColumns(columns.count)
                    }
                }
            }
        }
    }
}

#Preview {
    AchievementsGridView(sections: [
        AchievementSection(id: .personalRecord, achievements: [
            Achievement(id: "1", category: .personalRecord, title: "Longest Run", subtitle: "00:00", imageName: "longest_run", isEarned: true),
            Achievement(id: "2", category: .personalRecord, title: "Marathon", subtitle: "Not Yet", imageName: "fastest_marathon", isEarned: false)
        ]),
        AchievementSection(id: .virtualRace, achievements: [
            Achievement(id: "3", category: .virtualRace, title: "Virtual 5K Race", subtitle: "23:07", imageName: "virtual_5k_race", isEarned: true)
        ])
    ])
}
