//
//  SearchModel.swift
//  Domain
//
//  Created by ichikawa on 2020/10/28.
//

import Foundation

public struct SearchModel {
    public let popularTags: [NovelListModel.Novel.Tag]
    public let genres: [NovelListModel.Novel.SearchableGenre]
    public let sortField: [NovelListModel.Novel.SortField]
}
