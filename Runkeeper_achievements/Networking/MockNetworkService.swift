//
//  MockNetworkService.swift
//  Runkeeper_achievements
//
//  Simulates an achievements API by decoding bundled JSON fixtures under
//  Networking/Resources. Each scenario models a real response shape a
//  backend could plausibly return.
//

import Foundation

final class MockNetworkService: NetworkService {
    enum Scenario {
        /// A full set of achievements, including one locked/not-yet-earned personal record.
        case success
        /// No achievements returned at all.
        case empty
        case error
        /// Same payload as `.success`, but with a longer artificial delay to exercise loading state.
        case slow
    }

    private struct AchievementsResponse: Decodable {
        let achievements: [Achievement]
    }

    private let scenario: Scenario
    private let delay: Duration
    private let slowDelay: Duration

    init(scenario: Scenario = .success, delay: Duration = .milliseconds(200), slowDelay: Duration = .seconds(3)) {
        self.scenario = scenario
        self.delay = delay
        self.slowDelay = slowDelay
    }

    func fetchAchievements() async throws -> [Achievement] {
        switch scenario {
        case .success:
            try await Task.sleep(for: delay)
            return try loadFixture(named: "achievements_success")
        case .empty:
            try await Task.sleep(for: delay)
            return try loadFixture(named: "achievements_empty")
        case .error:
            try await Task.sleep(for: delay)
            throw NetworkError.requestFailed
        case .slow:
            try await Task.sleep(for: delay + slowDelay)
            return try loadFixture(named: "achievements_success")
        }
    }

    private func loadFixture(named name: String) throws -> [Achievement] {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            throw NetworkError.decodingFailed
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(AchievementsResponse.self, from: data).achievements
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
