//
//  NovelListCell.swift
//  Presentation
//
//  Created by ichikawa on 2020/09/01.
//

import UIKit

final class NovelListCell: UITableViewCell {
 
    @IBOutlet private weak var novelTitleLabel: UILabel!
    
    @IBOutlet private weak var authorLabel: UILabel!
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    func setData(_ num: Int) {
        self.novelTitleLabel.text = "title \(num)"
        self.authorLabel.text = "author \(num)"
        self.dateLabel.text = "date \(num)"
    }
}
