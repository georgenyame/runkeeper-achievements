//
//  AchievementsEmptyView.swift
//  Runkeeper_achievements
//
//  Shown when the request succeeds but there are no achievements yet.
//

import SwiftUI

struct AchievementsEmptyView: View {
    var body: some View {
        VStack(spacing: .spacingOne) {
            Image(systemName: "medal")
                .font(.system(size: 36))
                .foregroundStyle(Color.secondaryTextColor)

            Text("No Achievements Yet")
                .font(.secondaryFont)
                .foregroundStyle(Color.tertiaryColor)

            Text("Complete runs and races to start earning medals.")
                .font(.tertiaryFont)
                .foregroundStyle(Color.secondaryTextColor)
                .multilineTextAlignment(.center)
        }
        .padding(.spacingDouble)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AchievementsEmptyView()
}
