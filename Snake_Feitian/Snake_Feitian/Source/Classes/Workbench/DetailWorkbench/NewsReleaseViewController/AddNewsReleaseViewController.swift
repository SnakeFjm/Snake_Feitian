//
//  AddNewsReleaseViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/14.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class AddNewsReleaseViewController: BaseViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var scopeTextField: UITextField!
    
    //
    @IBOutlet weak var isHiddenView: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "新消息"
        //
        self.contentTextView.layer.borderWidth = 1
        self.contentTextView.layer.borderColor = UIColor.lightGray.cgColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.contentTextView.resignFirstResponder()
    }
    
    // =================================
    // MARK:
    // =================================
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.scopeTextField {
            //
            textField.resignFirstResponder()
            //
            let alertVC = UIAlertController.init(title: "请选择发送范围", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
            //
            let allAction = UIAlertAction.init(title: "全部", style: UIAlertActionStyle.default, handler: { (_) in
                self.scopeTextField.text = "全部"
            })
            //
            let areaAction = UIAlertAction.init(title: "区域", style: UIAlertActionStyle.default, handler: { (_) in
                self.scopeTextField.text = "区域"
            })
            let shopAction = UIAlertAction.init(title: "店铺", style: UIAlertActionStyle.default, handler: { (_) in
                self.scopeTextField.text = "店铺"
            })
            let ownAction = UIAlertAction.init(title: "个人", style: UIAlertActionStyle.default, handler: { (_) in
                self.scopeTextField.text = "个人"
            })
            let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
            //
            alertVC.addAction(cancelAction)
            alertVC.addAction(ownAction)
            alertVC.addAction(shopAction)
            alertVC.addAction(areaAction)
            alertVC.addAction(allAction)

            //
            self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // =================================
    // MARK:
    // =================================
    
    @IBAction func confirmButtonDidTouch(_ sender: Any) {
    }
    

}
