//
//  AchievementsViewModel.swift
//  Runkeeper_achievements
//

import Foundation
import Observation

@Observable
final class AchievementsViewModel {
    private(set) var state: ViewState = .idle

    private let networkService: NetworkService

    init(networkService: NetworkService = MockNetworkService()) {
        self.networkService = networkService
    }

    func load() async {
        state = .loading
        do {
            let achievements = try await networkService.fetchAchievements()
            state = .loaded(achievements)
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    var sections: [AchievementSection] {
        guard case .loaded(let achievements) = state else { return [] }
        return achievements.groupedIntoSections()
    }
}
