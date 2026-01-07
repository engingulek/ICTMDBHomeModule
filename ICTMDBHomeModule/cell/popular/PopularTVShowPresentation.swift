//
//  PopularTVShowPresentation.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import ICTMDBViewKit
// MARK: PopularTVShowPresentation
struct PopularTVShowPresentation: Equatable {
    var id: Int?
    var title: String
    var year: String
    var rating: Double
    var info: String
    var backdropPoster: String
    var mainPoster: String
    var flag: String
}

extension PopularTVShowPresentation {
    public init(tvShow: PopularTvShows) {
        self.id = tvShow.id
        self.title = tvShow.name ?? ""
        self.year = tvShow.firstAirDate?.toLongDateString() ?? ""
        self.rating = tvShow.voteAverage ?? 0.0
        self.info = tvShow.overview ?? ""
        self.mainPoster = "https://image.tmdb.org/t/p/w500\(tvShow.posterPath ?? "")"
        self.backdropPoster = "https://image.tmdb.org/t/p/w500\(tvShow.backdropPath ?? "")"
        self.flag = LanguageFlags.flag(for: tvShow.originalLanguage ?? "")
    }
}
