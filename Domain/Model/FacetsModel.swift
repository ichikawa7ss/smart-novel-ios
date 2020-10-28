//
//  FacetsModel.swift
//  Domain
//
//  Created by ichikawa on 2020/10/28.
//

import DataStore
import Foundation

public struct FacetsModel {

    let tags: [NovelListModel.Novel.Tag]
    let genres: [String]
}

extension FacetsModel {

    init(_ response: FacetsResponse) {
        self.tags = response.facets.tag.map { NovelListModel.Novel.Tag(name: $0.key) }
        self.genres = response.facets.genre.map { $0.key }
    }
}
