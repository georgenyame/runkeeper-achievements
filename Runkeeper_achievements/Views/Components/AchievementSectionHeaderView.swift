//
//  AchievementSectionHeaderView.swift
//  Runkeeper_achievements
//

import SwiftUI

struct AchievementSectionHeaderView: View {
    let section: AchievementSection

    var body: some View {
        HStack {
            Text(section.title)
                .font(.secondaryFont)
                .foregroundStyle(Color.secondaryTextColor)

            Spacer()

            if section.showsProgressCount {
                Text("\(section.earnedCount) of \(section.total)")
                    .font(.tertiaryFont)
                    .foregroundStyle(Color.secondaryTextColor)
            }
        }
        .padding(.horizontal, .spacingOne)
        .padding(.vertical, .spacingHalf)
        .frame(maxWidth: .infinity)
        .background(Color.secondaryColor)
    }
}

#Preview {
    VStack(spacing: .spacingZero) {
        AchievementSectionHeaderView(section: AchievementSection(id: .personalRecord, achievements: [
            Achievement(id: "1", category: .personalRecord, title: "Longest Run", subtitle: "00:00", imageName: "longest_run", isEarned: true),
            Achievement(id: "2", category: .personalRecord, title: "Marathon", subtitle: "Not Yet", imageName: "fastest_marathon", isEarned: false)
        ]))
        AchievementSectionHeaderView(section: AchievementSection(id: .virtualRace, achievements: [
            Achievement(id: "3", category: .virtualRace, title: "Virtual 5K Race", subtitle: "23:07", imageName: "virtual_5k_race", isEarned: true)
        ]))
    }
}
