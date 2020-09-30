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
        public let site: Site
        public let genre: String
        public let tags: [NovelListModel.Novel.Tag]
        public let updateTime: String
        
        public enum Site: String {
            case kakuyomu = "カクヨム"
            case alphapolis = "アルファポリス"
            
            public var colorCode: String {
                switch self {
                case .kakuyomu:
                    return "#4cace4"
                case .alphapolis:
                    return "#f4a424"
                }
            }
        }

    }
}

extension NovelListModel.Novel {

    init(_ novel: NovelListResponse.Result) {
        self.title = novel.title
        self.author = novel.author
        self.novelDetailUrl = URL(string: novel.url)
        self.site = Site(rawValue: novel.site) ?? .alphapolis
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
