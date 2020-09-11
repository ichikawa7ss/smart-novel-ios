//
//  Array+.swift
//  Presentation
//
//  Created by ichikawa on 2020/09/08.
//

import Foundation

extension Array {

    /// 範囲を超えてもクラッシュしない
    public subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }

    /// 範囲を超えてもクラッシュしない
    public subscript (reverse index: Int) -> Element {
        return self[self.count - index - 1]
    }
}
