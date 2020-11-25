//
//  LoadingViewManager.swift
//  Presentation
//
//  Created by ichikawa on 2020/11/07.
//

import Foundation
import UIKit

final class LoadingViewManager {
    
    private var showCount: Int = 0
    private weak var loadingView: LoadingView?
    
    func show(on view: UIView, type: LoadingView.BackgroundType = .clear) {
        if self.showCount == 0 {
            self.loadingView = LoadingView.show(on: view, type: type)
        }
        self.showCount += 1
    }
    
    func hide() {
        self.showCount -= 1
        if self.showCount == 0 {
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
        }
    }
}
