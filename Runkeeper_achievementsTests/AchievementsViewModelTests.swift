//
//  AchievementsViewModelTests.swift
//  Runkeeper_achievementsTests
//
//  Created by George Nyame on 2026-07-15.
//

import Foundation
import Testing
@testable import Runkeeper_achievements

@MainActor
struct AchievementsViewModelTests {

    @Test func successScenarioLoadsAchievements() async throws {
        let viewModel = AchievementsViewModel(networkService: MockNetworkService(scenario: .success, delay: .zero))

        #expect(viewModel.state == .idle)
        await viewModel.load()

        guard case .loaded(let achievements) = viewModel.state else {
            Issue.record("Expected .loaded state, got \(viewModel.state)")
            return
        }
        #expect(!achievements.isEmpty)
        #expect(achievements.contains { $0.isEarned == false })
    }

    @Test func emptyScenarioLoadsNoAchievements() async throws {
        let viewModel = AchievementsViewModel(networkService: MockNetworkService(scenario: .empty, delay: .zero))

        await viewModel.load()

        #expect(viewModel.state == .loaded([]))
        #expect(viewModel.sections.isEmpty)
    }

    @Test func errorScenarioSurfacesErrorState() async throws {
        let viewModel = AchievementsViewModel(networkService: MockNetworkService(scenario: .error, delay: .zero))

        await viewModel.load()

        guard case .error = viewModel.state else {
            Issue.record("Expected .error state, got \(viewModel.state)")
            return
        }
    }

    @Test func slowScenarioEventuallyLoadsAchievements() async throws {
        let viewModel = AchievementsViewModel(networkService: MockNetworkService(scenario: .slow, delay: .zero, slowDelay: .zero))

        await viewModel.load()

        guard case .loaded(let achievements) = viewModel.state else {
            Issue.record("Expected .loaded state, got \(viewModel.state)")
            return
        }
        #expect(!achievements.isEmpty)
    }

    @Test func sectionsGroupByCategoryWithKnownOrderFirst() async throws {
        let viewModel = AchievementsViewModel(networkService: MockNetworkService(scenario: .success, delay: .zero))
        await viewModel.load()

        let sections = viewModel.sections
        #expect(sections.map(\.id) == [.personalRecord, .virtualRace])
    }

    @Test func novelCategoryDecodesWithServerProvidedMetadataAndNeedsNoClientChanges() throws {
        let json = """
        { "id": "1", "category": { "id": "seasonalChallenge", "displayName": "Seasonal Challenges", "sortOrder": 2 }, "title": "Winter Challenge", "subtitle": "00:00", "imageName": "longest_run", "isEarned": true }
        """.data(using: .utf8)!

        let achievement = try JSONDecoder().decode(Achievement.self, from: json)
        #expect(achievement.category.id == "seasonalChallenge")
        #expect(achievement.category.displayName == "Seasonal Challenges")
        #expect(achievement.category.sortOrder == 2)
    }

    @Test func categoryMissingDisplayNameOrSortOrderFailsDecodingRatherThanGuessing() {
        let json = """
        { "id": "1", "category": { "id": "seasonalChallenge" }, "title": "Winter Challenge", "subtitle": "00:00", "imageName": "longest_run", "isEarned": true }
        """.data(using: .utf8)!

        #expect(throws: (any Error).self) {
            try JSONDecoder().decode(Achievement.self, from: json)
        }
    }
}
