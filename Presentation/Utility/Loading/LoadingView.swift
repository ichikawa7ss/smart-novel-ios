//
//  LoadingView.swift
//  Presentation
//
//  Created by ichikawa on 2020/11/07.
//

import Foundation
import UIKit

final class LoadingView: BaseView {

    enum BackgroundType {
        case clear
        case black

        var color: UIColor {
            switch self {
            case .clear :
                return .clear
            case .black :
                return UIColor.black.withAlphaComponent(0.5)
            }
        }
    }

    private var type: BackgroundType = .clear
}

extension LoadingView {

    static func show(on view: UIView, type: BackgroundType = .clear) -> LoadingView {
        let loadingView = LoadingView()
        loadingView.backgroundColor = type.color
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
        loadingView.matchParent(view)
        return loadingView
    }
}
