//
//  SortFilterCell.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/18.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

final class SortFilterCell: UITableViewCell {

    @IBOutlet private weak var sortFieldLabel: UILabel!
    @IBOutlet private weak var changeSortFieldView: UIView! {
        willSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapChangeSortFieldView))
            newValue.addGestureRecognizer(tapGesture)
        }
    }
    var changeSortFiledDidTapRelay = PublishRelay<Void>()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    func setData(text: String) {
        self.sortFieldLabel.text = text
    }
    
    @objc func tapChangeSortFieldView(_ sender: Any) {
        self.changeSortFiledDidTapRelay.accept(())
    }
}
