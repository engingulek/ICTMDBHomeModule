//
//  PopularTVShowPresentation.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

import ICTMDBViewKit
struct PopularTVShowPresentation: Equatable {
    var id:Int?
    var title: String
    var year: String
    var rating: Double
    var info:String
    var backdropPoster:String
    var mainPoster:String
    var flag:String
    
    init(id:Int?,
        title: String,
        year: String,
        rating: Double,
        info:String,
        category:String,
        backdropPoster:String,
        mainPoster:String,
        flag : String) {
        self.id = id
        self.title = title
        self.year = year
        self.rating = rating
        self.info = info
        self.backdropPoster = backdropPoster
        self.mainPoster = mainPoster
        self.flag = flag
    }
}


extension PopularTVShowPresentation {
    public init(tvShow: PopularTvShows) {
        self.id = tvShow.id
        self.title = tvShow.name
        self.year = tvShow.firstAirDate.toLongDateString() ?? tvShow.firstAirDate
        self.rating = tvShow.voteAverage
        self.info = tvShow.overview
        self.mainPoster = "https://image.tmdb.org/t/p/w500\(tvShow.posterPath)"
        self.backdropPoster = "https://image.tmdb.org/t/p/w500\(tvShow.backdropPath)"
        self.flag = LanguageFlags.flag(for: tvShow.originalLanguage)
    }
}
