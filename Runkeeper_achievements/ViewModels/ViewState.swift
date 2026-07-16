//
//  ViewState.swift
//  Runkeeper_achievements
//

enum ViewState: Equatable {
    case idle
    case loading
    case loaded([Achievement])
    case error(String)
}
