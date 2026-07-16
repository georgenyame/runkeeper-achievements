//
//  NetworkError.swift
//  Runkeeper_achievements
//
//  Created by George Nyame on 2026-07-15.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case requestFailed
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .requestFailed:
            return "We couldn't load your achievements. Please check your connection and try again."
        case .decodingFailed:
            return "Something went wrong while reading your achievements."
        }
    }
}
