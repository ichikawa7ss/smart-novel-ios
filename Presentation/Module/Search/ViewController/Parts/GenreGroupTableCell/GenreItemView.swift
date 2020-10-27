//
//  GenreItemView.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/27.
//

import Domain
import UIKit
import RxSwift
import RxCocoa

final class GenreItemView: BaseView {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var itemButton: HoverView!
    
    var itemButtonDidTapRelay = PublishRelay<NovelListModel.Novel.SearchableGenre>()
    
    func setData(_ genre: NovelListModel.Novel.SearchableGenre) {
        self.label.text = genre.rawValue
        self.icon.image = UIImage(named: "robot")
        
        self.itemButton.didTouchUpInsideObservable
            .map { genre }
            .bind(to: self.itemButtonDidTapRelay)
            .disposed(by: self.disposeBag)
    }
}
