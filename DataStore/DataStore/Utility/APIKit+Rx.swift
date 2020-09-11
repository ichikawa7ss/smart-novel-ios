//
//  APIKit+Rx.swift
//  DataStore
//
//  Created by ichikawa on 2020/09/05.
//

import APIKit
import RxSwift

extension Session: ReactiveCompatible {}

extension Reactive where Base: Session {
    
    func response<T: Request>(for request: T) -> Single<T.Response> {

        return Single.create { [weak base] single -> Disposable in
            let task = base?.send(request) { result in
                switch result {
                case .success(let response):
                    single(.success(response))
                case .failure(let error):
                    single(.error(error))
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
