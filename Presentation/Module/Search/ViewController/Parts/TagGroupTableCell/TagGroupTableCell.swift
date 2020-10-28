//
//  TagGroupTableCell.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/28.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import TagListView

final class TagGroupTableCell: UITableViewCell {

    @IBOutlet private weak var tagListView: TagListView!
    
    var tagDidTapRelay = PublishRelay<NovelListModel.Novel.Tag>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(_ tags: [NovelListModel.Novel.Tag]) {
        // 一度タグを消しておく
        self.tagListView.removeAllTags()
        self.tagListView.textFont = UIFont(name: "HiraginoSans-W3", size: 12.0) ?? UIFont()

        // Book.tagsをTagListViewに追加
        for tag in tags {
            let tagView = self.tagListView.addTag(tag.name)
            tagView.onTap = { [weak self] _ in
                self?.tagDidTapRelay.accept(tag)
                tagView.alpha = 0.4
            }
        }
        // タグ全体の高さを取得し、frameのサイズを更新
        self.tagListView.frame.size.height = self.tagListView.intrinsicContentSize.height
    }
}

