//
//  SplashUseCase.swift
//  Domain
//
//  Created by ichikawa on 2020/10/28.
//

import Foundation
import DataStore
import RxSwift

public enum SplashUseCaseProvider {
    
    public static func provide() -> SplashUseCase {
        return SplashUseCaseImpl(
            facetsRepository: FacetsRepositoryProvider.provide(),
            facetsTranslator: FacetsTranslatorProvider.provide()
        )
    }
}

public protocol SplashUseCase {
    func get() -> Single<FacetsModel>
}

private struct SplashUseCaseImpl: SplashUseCase {

    private let facetsRepository: FacetsRepository
    
    private let facetsTranslator: FacetsTranslator
    
    init(facetsRepository: FacetsRepository, facetsTranslator: FacetsTranslator) {
        self.facetsRepository = facetsRepository
        self.facetsTranslator = facetsTranslator
    }
    
    func get() -> Single<FacetsModel> {
        return self.facetsTranslator.convert(from: self.facetsRepository.get())
    }
}

