//
//  AlertHelper.swift
//  FoodDetect
//
//  Created by dev on 2017/12/5.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//


import Foundation
import UIKit
import QMUIKit


// ================================
// MARK: 弹窗
// ================================

typealias AlertCompletion = (_ action: QMUIAlertAction?, _ index: Int) -> Void

typealias AlertTextFieldCompletion = (_ action: QMUIAlertAction?, _ index: Int, _ content: String?) -> Void

// 显示一个简单提示语的 Alert(不关心回调处理)
func showAlertController(title: String, message: String) {
    showAlertController(title: title, message: message, cancelTitle: STR_CONFIRM, confirmTitle: nil, completion: nil)
}

// 显示一个简单提示语的Alert（关心回调处理）
func showAlertControllerWithConfirmCompletion(title: String, message: String, confirmCompletion: AlertCompletion?) {
    showAlertController(title: title, message: message, cancelTitle: nil, confirmTitle: STR_CONFIRM, completion: confirmCompletion)
}


// 显示一个alertView
func showAlertController(title: String, message: String, completion: AlertCompletion?) {
    
    showAlertController(title: title, message: message, cancelTitle: STR_CANCEL, confirmTitle: STR_CONFIRM, completion: completion)
}


func showAlertController(title: String, message: String, cancelTitle: String?, confirmTitle: String?, completion: AlertCompletion?) {
    showAlertController(style: .alert, title: title, message: message, cancelTitle: cancelTitle, confirmTitle: confirmTitle, completion: completion)
}


// 显示一个alertView
func showAlertController(style: QMUIAlertControllerStyle, title: String, message: String, cancelTitle: String?, confirmTitle: String?, completion: AlertCompletion?) {
    
    let alert: QMUIAlertController = QMUIAlertController(title: title, message: message, preferredStyle: style)
    
    if confirmTitle != nil {
        alert.addAction(QMUIAlertAction.init(title: confirmTitle, style: QMUIAlertActionStyle.default, handler: { (action: QMUIAlertAction?) in
            if completion != nil {
                completion!(action, 1)
            }
        }))
    }
    
    if cancelTitle != nil {
        alert.addAction(QMUIAlertAction.init(title: cancelTitle, style: QMUIAlertActionStyle.cancel, handler: { (action: QMUIAlertAction?) in
            if completion != nil {
                completion!(action, 0)
            }
        }))
    }
    
    alert.showWith(animated: true)
}


// 显示一个带TextField的AlertView
func showAlertTextFieldController(title: String, message: String, content: String, placeholder: String, cancelTitle: String?, confirmTitle: String?, completion: AlertTextFieldCompletion?) {
    
    let alert: QMUIAlertController = QMUIAlertController(title: title, message: message, preferredStyle: .alert)
    
    var tempField: UITextField!
    
    alert.addTextField { (textField: UITextField?) in
        if textField != nil {
            tempField = textField
        }
        textField?.text = content
        textField?.placeholder =  placeholder
    }
    
    if confirmTitle != nil {
        alert.addAction(QMUIAlertAction.init(title: confirmTitle, style: .destructive, handler: { (action: QMUIAlertAction?) in
            if completion != nil {
                completion!(action, 1, tempField.text)
            }
        }))
    }
    
    if cancelTitle != nil {
        alert.addAction(QMUIAlertAction.init(title: cancelTitle, style: .cancel, handler: { (action: QMUIAlertAction?) in
            if completion != nil {
                completion!(action, 0, tempField.text)
            }
        }))
    }
    
    
    
    alert.showWith(animated: true)
}



// 显示一个 ActionSheet

func showActionSheet(title: String?, message: String?, cancelTitle: String, otherTitles: [String], completion: AlertCompletion?) {
    
    let alertController: QMUIAlertController = QMUIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    
    alertController.addAction(QMUIAlertAction.init(title: cancelTitle, style: .cancel, handler: { (action: QMUIAlertAction?) in
        if completion != nil {
            completion!(action, 0)
        }
    }))
    
    for index in 0..<otherTitles.count {
        let title = otherTitles[index]
        
        alertController.addAction(QMUIAlertAction.init(title: title, style: .default, handler: { (action: QMUIAlertAction?) in
            if completion != nil {
                completion!(action, index + 1)
            }
        }))
    }
    
    alertController.showWith(animated: true)
}


func showActionSheet(title: String, otherTitles: [String], completion: AlertCompletion?) {
    showActionSheet(title: title, message: "", cancelTitle: STR_CANCEL, otherTitles: otherTitles, completion: completion)
}



