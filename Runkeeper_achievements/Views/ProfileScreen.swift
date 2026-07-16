//
//  ProfileScreen.swift
//  Runkeeper_achievements
//
//  Minimal placeholder parent screen. In the real app, Achievements is
//  reached by pushing from somewhere like Profile — the mock's nav bar
//  shows a back chevron, confirming it's a detail view, not a bare root.
//  This stand-in exists purely so AchievementsScreen is pushed authentically.
//

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        List {
            NavigationLink {
                AchievementsScreen()
            } label: {
                Label("Achievements", systemImage: "medal")
            }

            #if DEBUG
            Section("Debug") {
                NavigationLink {
                    ScenarioDemoView()
                } label: {
                    Label("Scenario Demo", systemImage: "wrench.and.screwdriver")
                }
            }
            #endif
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ProfileScreen()
    }
}
