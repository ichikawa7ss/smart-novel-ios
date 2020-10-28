//
//  SearchTransitType.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/20.
//

import Foundation
import Domain

enum SearchTransitType {
    
    case text(text: String, sortField: NovelListModel.Novel.SortField)
    case genre(genre: [String], sortField: NovelListModel.Novel.SortField)
    case tag(tag: [String], sortField: NovelListModel.Novel.SortField)
}
