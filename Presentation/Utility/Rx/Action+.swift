//
//  Action+.swift
//  Presentation
//
//  Created by ichikawa on 2020/11/07.
//

import Action
import RxCocoa
import RxSwift

extension Action {
    
    // 正常系
    var normalState: Observable<NetworkState> {
        return .merge(
            // executingがtrueの場合はloadingを流す
            executing
                .filter { $0 }
                .map { _ in
                    NetworkState.loading
                },
            // elementsはnormalとして流す
            elements
                .flatMap { _ -> Observable<NetworkState> in
                    .just(NetworkState.normal)
            }
            
        )
    }
    
    // エラー含むbindするためのネットワーク状態
    var state: Observable<NetworkState> {
        return .merge(
            normalState,
            
            underlyingError
                .flatMap { error -> Observable<NetworkState> in
                    return .just(NetworkState.error)
                }
        )
    }
}
