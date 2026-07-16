//
//  LoadingView.swift
//  Runkeeper_achievements
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: .spacingThreeQuarters) {
            ProgressView()
                .tint(Color.primaryColor)
            Text("Loading your achievements…")
                .font(.secondaryFont)
                .foregroundStyle(Color.secondaryTextColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView()
}
