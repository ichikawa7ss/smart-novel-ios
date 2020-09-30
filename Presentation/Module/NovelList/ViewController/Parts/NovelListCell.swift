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
    
    func setData(_ item: NovelListModel.Novel) {
        // TODO : NovelList用に差し替え
    }
}
