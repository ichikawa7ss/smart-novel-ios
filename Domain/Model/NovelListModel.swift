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
            case kakuyomu
            case alphapolis
            case novelba
            case syosetukaninarou
            
            public var colorCode: String {
                switch self {
                case .kakuyomu:
                    return "#4cace4"
                case .alphapolis:
                    return "#f4a424"
                case .novelba:
                    return "#2CC199"
                case .syosetukaninarou:
                    return "#16B6CD"
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
    
    public enum SortField: String, CaseIterable {
        case latest
        case score
    }

    public enum SearchableGenre: String, CaseIterable {
        case fantasy = "ファンタジー"
        case love = "恋愛"
        case mystery = "ミステリー"
        case drama = "ドラマ"
        case essay = "エッセイ"
        case sf = "SF"
        
        public var filters: [String] {
            switch self {
            case .fantasy:
                return ["ファンタジー", "現代ファンタジー", "ハイファンタジー", "ローファンタジー", "異世界ファンタジー"]
            case .love:
                return ["恋愛", "ラブコメ", "BL"]
            case .mystery:
                return ["ミステリー"]
            case .drama:
                return ["現代ドラマ"]
            case .essay:
                return ["エッセイ・ノンフィクション", "ｴｯｾｲ・ﾉﾝﾌｨｸｼｮﾝ"]
            case .sf:
                return ["SF"]
            }
        }
    }
}

extension NovelListModel.Novel.Tag {
    public var sharpTagName: String {
        return "#\(self.name)"
    }
}
