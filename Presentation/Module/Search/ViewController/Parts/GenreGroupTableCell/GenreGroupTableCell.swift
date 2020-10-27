//
//  GenreGroupTableCell.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/27.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

final class GenreGroupTableCell: UITableViewCell {

    @IBOutlet private var genreItemViewCollection: [GenreItemView]!
    
    var genreViewDidTapRelay = PublishRelay<NovelListModel.Novel.Tag>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(_ tags: [NovelListModel.Novel.Tag]) {
        self.genreItemViewCollection.enumerated().map {
            $0.element.setData(tags[$0.offset])
            $0.element.itemButtonDidTapRelay
                .bind (onNext:{ tag in
                    self.genreViewDidTapRelay.accept(tag)
                })
                .disposed(by: self.disposeBag)
        }
    }
}
