//
//  BaseViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/6.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import QMUIKit

class BaseViewController: QMUICommonViewController {
    
    var isHiddenNavigationBarShadowLine: Bool = false // 是否需要隐藏导航栏的分割线
    
    var rightBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override var nibName: String? {
//        var result: String? = nil
//        let name:String = NSStringFromClass(self.classForCoder)
//        let arr = name.components(separatedBy: ".")
//        result = arr.last
//
//        let path: String? = Bundle.main.path(forResource: result, ofType: "nib")
//        if path == nil {
//            return nil
//        } else {
//            return result
//        }
//
//    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        self.view.endEditing(true)
        
        // 倒数第二个控制器退栈的时候，需要设置显示tabbar
        if self.navigationController != nil && self.navigationController?.viewControllers.count == 2 {
            self.hidesBottomBarWhenPushed = false
        }
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    // =================================
    // MARK:
    // =================================
    
    func navBarAddRightBarButton(title: String) {
        self.rightBarButton = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(navBarRightBarButtonDidTouch(_:)))
        self.navigationItem.rightBarButtonItem = self.rightBarButton
    }
    
    func navBarAddRightBarButton(image: UIImage) {
        self.rightBarButton = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(navBarRightBarButtonDidTouch(_:)))
        self.navigationItem.rightBarButtonItem = self.rightBarButton
    }
    
    @objc func navBarRightBarButtonDidTouch(_ sender: Any) {
        
    }

}
