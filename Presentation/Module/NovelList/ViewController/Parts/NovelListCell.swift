//
//  NovelListCell.swift
//  Presentation
//
//  Created by ichikawa on 2020/09/01.
//

import UIKit
import Domain

final class NovelListCell: UITableViewCell {
 
    @IBOutlet private weak var novelTitleLabel: UILabel!
    
    @IBOutlet private weak var authorLabel: UILabel!
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    @IBOutlet private weak var siteColorView: UIView!
    
    @IBOutlet private weak var tagLabel: UILabel!
    
    func setData(_ item: NovelListModel.Novel) {
        self.novelTitleLabel.text = item.title
        self.authorLabel.text = item.author
        self.dateLabel.text = item.updateTime
        self.tagLabel.text = item.tags.map { $0.name }.joined(separator: " ")
        self.siteColorView.backgroundColor = UIColor(hex: item.site.colorCode)
        
        /// TODO: タグの作成
        /// タグはラベルの文字列をUnicode変換？→色を生成
        /// 色の精製方法は以下の5番を使えばいいかな
        /// https://q-az.net/random-color-code/
        ///
    }
}
    
