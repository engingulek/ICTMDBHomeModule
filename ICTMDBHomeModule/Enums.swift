//
//  Enums.swift
//  ICTMDBHomeModule
//
//  Created by Engin Gülek on 12.11.2025.
//

enum CellItemType {
    case popular(String)
    case airing(String)
    case none
}

//MARK: SectionType
enum SectionType: Int, CaseIterable {
    case popular
    case airingToday
}
