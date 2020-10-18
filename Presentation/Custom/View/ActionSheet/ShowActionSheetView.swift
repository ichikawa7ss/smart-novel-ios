//
//  ShowActionSheetView.swift
//  Presentation
//
//  Created by ichikawa on 2020/10/18.
//

import UIKit

protocol ActionSheetItem {

    var text: String { get }
}

protocol ShowActionSheetView {
    func showActionSheet<T: ActionSheetItem>(title: String?, message: String?, items: [T], completion: @escaping ((T) -> Void), cancelHandler: (() -> Void)?)
}

extension ShowActionSheetView where Self: UIViewController {

    func showActionSheet<T: ActionSheetItem>(title: String?, message: String?, items: [T], completion: @escaping ((T) -> Void), cancelHandler: (() -> Void)? = nil) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)

        let actions: [UIAlertAction] = items.map { item -> UIAlertAction in
            return UIAlertAction(
                title: item.text,
                style: .default,
                handler: { _ in
                    completion(item)
            })
        }

        // iPadでは表示元のVCを指定しないとおちる
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.width / 2, y: self.view.frame.height, width: 0, height: 0)
        
        actions.forEach { actionSheet.addAction($0) }

        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (_: UIAlertAction!) -> Void in
            cancelHandler?()
        })

        actionSheet.addAction(cancelAction)

        self.present(actionSheet, animated: true, completion: nil)
    }
}
