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
        self.icon.image = genre.generateIcon()
        
        self.itemButton.didTouchUpInsideObservable
            .map { genre }
            .bind(onNext: { genre in
                self.itemButtonDidTapRelay.accept(genre)
            })
            .disposed(by: self.disposeBag)
    }
}

extension NovelListModel.Novel.SearchableGenre {
    
    func generateIcon() -> UIImage? {
        switch self {
        case .fantasy:
            return UIImage(named: "fantasy")
        case .love:
            return UIImage(named: "heart")
        case .mystery:
            return UIImage(named: "mystery")
        case .drama:
            return UIImage(named: "drama")
        case .essay:
            return UIImage(named: "essay")
        case .sf:
            return UIImage(named: "robot")
        }
    }
}
