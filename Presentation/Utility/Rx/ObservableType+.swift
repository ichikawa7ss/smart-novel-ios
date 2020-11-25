//
//  ObservableType+.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/04.
//

import RxCocoa
import RxSwift

// MARK: ObservableType where E: OptionalType
extension ObservableType where Element: OptionalType {

    /// Filters out the nil elements of a sequence of optional elements
    /// - returns: An observable sequence of only the non-nil elements
    func filterNil() -> Observable<Element.Wrapped> {
        return flatMap { item -> Observable<Element.Wrapped> in
            if let value = item.value {
                return .just(value)
            }
            else {
                return .empty()
            }
        }
    }
}
