//
//  NovelListModel.swift
//  Domain
//
//  Created by ichikawa on 2020/09/29.
//

import DataStore
import Foundation

// MARK: - PokemonListModel
public struct NovelListModel {

    public let count: Int
    public let novels: [Novel]
}

extension NovelListModel {

    init(_ response: NovelListResponse) {
        self.count = response.count
        self.novels = response.novels.map { Novel($0) }
    }
}

// MARK: - Novel
extension NovelListModel {

    public struct Novel {
        
        public let title: String
        public let author: String
        public let novelDetailUrl: URL?
        public let site: String
        public let genre: String
        public let tags: [NovelListModel.Novel.Tag]
        public let updateTime: String
    }
}

extension NovelListModel.Novel {

    init(_ novel: NovelListResponse.Result) {
        self.title = novel.title
        self.author = novel.author
        self.novelDetailUrl = URL(string: novel.url)
        self.site = novel.site
        self.genre = novel.genre
        self.tags = novel.tags.map { Tag(name: $0.name) }
        self.updateTime = novel.updateTime
    }
}

extension NovelListModel.Novel {
    
    public struct Tag {
        public let name: String
    }
}
