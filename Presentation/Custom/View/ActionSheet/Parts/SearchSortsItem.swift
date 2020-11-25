//
//  SearchSortsItem.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/18.
//

import Foundation
import Domain

extension NovelListModel.Novel.SortField: ActionSheetItem {
    
    public var text: String {
        switch self {
        case .latest:
            return "新着順"
        case .score:
            return "関連度順"
        }
    }
}
