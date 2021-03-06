//
//  NovelListCell.swift
//  Presentation
//
//  Created by ichikawa on 2020/09/01.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

final class NovelListCell: UITableViewCell {
 
    @IBOutlet private weak var novelTitleLabel: UILabel!
    
    @IBOutlet private weak var authorLabel: UILabel!
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    @IBOutlet private weak var siteColorView: UIView!
    
    @IBOutlet private weak var tagLabel: UILabel!
    
    @IBOutlet private weak var genreLabel: UILabel!
    
    @IBOutlet private weak var underline: UIView!
    
    var cellDidTapRelay = PublishRelay<NovelListModel.Novel>()
    
    var novel: NovelListModel.Novel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCell))
        self.addGestureRecognizer(tapGesture)
    }
    
    func setData(_ item: NovelListModel.Novel) {
        self.novel = item
        self.novelTitleLabel.text = item.title
        self.authorLabel.text = item.author
        self.dateLabel.text = self.trimTime(isoDateStr: item.updateTime)
        self.tagLabel.text = item.tags.map { $0.sharpTagName }.joined(separator: " ")
        self.siteColorView.backgroundColor = UIColor(hex: item.site.colorCode)
        self.genreLabel.text = item.genre
        self.genreLabel.textColor = UIColor(hex: "CC3300")
        self.underline.backgroundColor = UIColor(hex: "CC3300")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    /// yyyy-MM-DDTHH:mm:ssZ形式の日付の文字列をyyyy/MM/DD HH:mm に変換する
    private func trimTime(isoDateStr: String) -> String {
        let date = isoDateStr.components(separatedBy: "T")[0]
        let time = isoDateStr.components(separatedBy: "T")[1]
        return "\(date) \(time.prefix(5))"
    }
    
    @objc func tapCell() {
        if let novel = self.novel {
            self.cellDidTapRelay.accept(novel)
        }
    }
}
