//
//  AiringTodayPresentation.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//
import ICTMDBViewKit

// MARK: AiringTodayPresentation
struct AiringTodayPresentation: Equatable {
    var id: Int?
    var title: String
    var flag: String
    var rating: Double
    var mainPoster: String
}

extension AiringTodayPresentation {
    public init(tvShow: AiringToday) {
        self.id = tvShow.id
        self.title = tvShow.name ?? ""
        self.flag = LanguageFlags.flag(for: tvShow.originalLanguage ?? "")
        self.rating = tvShow.voteAverage ?? 0.0
        self.mainPoster = "https://image.tmdb.org/t/p/w500\(tvShow.posterPath ?? "")"
    }
}
