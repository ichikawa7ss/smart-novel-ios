//
//  SearchCandidateTagCell.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/17.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

class SearchCandidateTagCell: UITableViewCell {

    @IBOutlet private weak var tagNameLabel: UILabel!
    
    var cellDidTapRelay = PublishRelay<NovelListModel.Novel.Tag>()
    var myTag: NovelListModel.Novel.Tag?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCell))
        self.addGestureRecognizer(tapGesture)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    func setData(_ tag: NovelListModel.Novel.Tag) {
        self.myTag = tag
        self.tagNameLabel.text = tag.name
    }
    
    
    @objc func tapCell() {
        if let myTag = self.myTag {
            self.cellDidTapRelay.accept(myTag)
        }
    }

}
