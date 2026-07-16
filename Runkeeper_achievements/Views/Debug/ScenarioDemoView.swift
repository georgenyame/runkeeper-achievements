//
//  ScenarioDemoView.swift
//  Runkeeper_achievements
//
//  Manual QA aid: a list of MockNetworkService scenarios, each pushing to
//  its own AchievementsScreen so every ViewState can be visually verified.
//  Reached from ProfileScreen's Debug section (#if DEBUG only) or via the
//  #Preview below — never part of a release build.
//

import SwiftUI

struct ScenarioDemoView: View {
    private struct Row: Identifiable {
        let id: String
        let title: String
        let subtitle: String
        let systemImage: String
        let scenario: MockNetworkService.Scenario
    }

    private let rows: [Row] = [
        Row(id: "success", title: "Success", subtitle: "Full achievements list, incl. a locked personal record", systemImage: "checkmark.circle", scenario: .success),
        Row(id: "empty", title: "Empty", subtitle: "No achievements earned yet", systemImage: "tray", scenario: .empty),
        Row(id: "error", title: "Error", subtitle: "Request fails; shows the error view with retry", systemImage: "exclamationmark.triangle", scenario: .error),
        Row(id: "slow", title: "Slow", subtitle: "Longer artificial delay; exercises the loading view", systemImage: "clock", scenario: .slow)
    ]

    var body: some View {
        List(rows) { row in
            NavigationLink {
                AchievementsScreen(viewModel: AchievementsViewModel(networkService: MockNetworkService(scenario: row.scenario)))
            } label: {
                Label {
                    VStack(alignment: .leading, spacing: .spacingEighth) {
                        Text(row.title)
                            .font(.secondaryFont)
                        Text(row.subtitle)
                            .font(.tertiaryFont)
                            .foregroundStyle(Color.secondaryTextColor)
                    }
                } icon: {
                    Image(systemName: row.systemImage)
                        .foregroundStyle(Color.primaryColor)
                }
            }
        }
        .navigationTitle("Scenarios")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ScenarioDemoView()
    }
}
