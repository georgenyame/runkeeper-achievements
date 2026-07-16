//
//  AchievementView.swift
//  Runkeeper_achievements
//

import SwiftUI

struct AchievementView: View {
    let achievement: Achievement

    var body: some View {
        VStack(spacing: .spacingHalf) {
            Image(achievement.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 72, height: 72)
                .opacity(achievement.isEarned ? 1 : 0.35)

            Text(achievement.title)
                .font(.secondaryFont)
                .foregroundStyle(Color.tertiaryColor)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.horizontal, .spacingOneAndQuarter)

            Text(achievement.subtitle)
                .font(.tertiaryFont)
                .foregroundStyle(Color.tertiaryTextColor.opacity(achievement.isEarned ? 1 : 0.6))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, .spacingThreeQuarters)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(achievement.title), \(achievement.subtitle)\(achievement.isEarned ? "" : ", not yet earned")")
    }
}

#Preview {
    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
        AchievementView(achievement: Achievement(id: "1", category: .personalRecord, title: "Longest Run", subtitle: "00:00", imageName: "longest_run", isEarned: true))
        AchievementView(achievement: Achievement(id: "2", category: .personalRecord, title: "Marathon", subtitle: "Not Yet", imageName: "fastest_marathon", isEarned: false))
    }
    .padding()
}
