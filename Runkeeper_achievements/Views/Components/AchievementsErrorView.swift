//
//  AchievementsErrorView.swift
//  Runkeeper_achievements
//

import SwiftUI

struct AchievementsErrorView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        VStack(spacing: .spacingOne) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 36))
                .foregroundStyle(Color.tertiaryColor)

            Text(message)
                .font(.secondaryFont)
                .foregroundStyle(Color.tertiaryColor)
                .multilineTextAlignment(.center)

            Button(action: retry) {
                Text("Retry")
                    .font(.secondaryFont)
                    .foregroundStyle(Color.primaryTextColor)
                    .padding(.horizontal, .spacingOneAndHalf)
                    .padding(.vertical, .spacingHalf)
                    .background(Color.primaryColor)
                    .clipShape(Capsule())
            }
        }
        .padding(.spacingDouble)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AchievementsErrorView(message: "We couldn't load your achievements. Please check your connection and try again.", retry: {})
}
