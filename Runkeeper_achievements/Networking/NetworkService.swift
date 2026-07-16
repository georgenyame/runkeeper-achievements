//
//  NetworkService.swift
//  Runkeeper_achievements
//

import Foundation

protocol NetworkService {
    func fetchAchievements() async throws -> [Achievement]
}
