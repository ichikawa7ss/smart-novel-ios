//
//  SmartNovelDomain.swift
//  Domain
//
//  Created by ichikawa on 2020/10/28.
//

import Foundation

/// シングルトンで保持しておきたい定義のうちDomain層で扱うべきもの
public class SmartNovelDomain {

    public static let shared = SmartNovelDomain()

    /// AppDelegate or SceneDelegateのUIWindow
    private(set) var popularTags = [NovelListModel.Novel.Tag]()
    
    private init() {}
}

extension SmartNovelDomain {

    public func setSearchableTags(_ popularTags: [NovelListModel.Novel.Tag]) {
        self.popularTags = popularTags
    }
}
