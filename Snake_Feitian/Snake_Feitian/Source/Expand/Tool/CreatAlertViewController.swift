//
//  CustomerUIAlertViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/12/7.
//  Copyright © 2017年 Snake. All rights reserved.
//

import Foundation

func showConfirmAlertViewVC(titleVC: String, message: String, confirmHandler: ((UIAlertAction) -> Void)?) -> UIAlertController {
    
    let alertVC = UIAlertController.init(title: titleVC, message: message, preferredStyle: .alert)
    let confirmAction = UIAlertAction.init(title: "确认", style: .default, handler: confirmHandler)
    
    alertVC.addAction(confirmAction)
    
    return alertVC
}

