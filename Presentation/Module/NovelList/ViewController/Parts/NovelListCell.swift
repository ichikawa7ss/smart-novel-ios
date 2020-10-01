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
        self.dateLabel.text = self.trimTime(isoDateStr: item.updateTime)
        self.tagLabel.text = item.tags.map { $0.sharpTagName }.joined(separator: " ")
        self.siteColorView.backgroundColor = UIColor(hex: item.site.colorCode)
    }
    
    /// yyyy-MM-DDTHH:mm:ssZ形式の日付の文字列をyyyy/MM/DD HH:mm に変換する
    private func trimTime(isoDateStr: String) -> String {
        let date = isoDateStr.components(separatedBy: "T")[0]
        let time = isoDateStr.components(separatedBy: "T")[1]
        return "\(date) \(time.prefix(5))"
    }
}
