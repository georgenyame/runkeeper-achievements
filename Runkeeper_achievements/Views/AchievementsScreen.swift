//
//  AchievementsScreen.swift
//  Runkeeper_achievements
//
//  Top-level medal case screen. Owns an AchievementsViewModel and renders
//  the appropriate content for each ViewState.
//

import SwiftUI

struct AchievementsScreen: View {
    @State private var viewModel: AchievementsViewModel

    init(viewModel: AchievementsViewModel = AchievementsViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        // `content`'s underlying view type changes shape with each ViewState
        // (EmptyView / LoadingView / AchievementsGridView / AchievementsErrorView).
        // Wrapping it in a stable container keeps `.task`'s identity fixed so it
        // runs once on first appearance instead of restarting on every state change.
        ZStack {
            content
        }
        .navigationTitle("Achievements")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.primaryColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .task {
            await viewModel.load()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            EmptyView()
        case .loading:
            LoadingView()
        case .loaded:
            if viewModel.sections.isEmpty {
                AchievementsEmptyView()
            } else {
                AchievementsGridView(sections: viewModel.sections)
            }
        case .error(let message):
            AchievementsErrorView(message: message) {
                Task { await viewModel.load() }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileScreen()
    }
}
