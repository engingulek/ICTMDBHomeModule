//
//  Enums.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

enum CellItemType {
    case popular(PopularTVShowPresentation)
    case airing(AiringTodayPresentation)
    case none
}

// MARK: SectionType
enum SectionType: Int, CaseIterable {
    case popular
    case airingToday
}

// MARK: HomePageErrorType
enum HomePageErrorType {
    case popular
    case airingToday
}
