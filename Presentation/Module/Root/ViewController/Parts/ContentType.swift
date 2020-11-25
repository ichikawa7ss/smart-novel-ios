//
//  ContentType.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/25.
//

import Foundation

/// スイッチングで表示するコンテンツのタイプ
enum ContentType: Int {
    case home
    case search
    
    /// セットで表示する遷移先を示すボタンのタイプ.
    enum DestinationButtonType {
        case toSearch
        case toHome
        
        var toContentType: ContentType {
            switch self {
            case .toSearch:
                return .search
            case .toHome:
                return .home
            }
        }
    }
    
    var buttonType: DestinationButtonType {
        switch self {
        case .home:
            return .toSearch
        case .search:
            return .toHome
        }
    }
}
