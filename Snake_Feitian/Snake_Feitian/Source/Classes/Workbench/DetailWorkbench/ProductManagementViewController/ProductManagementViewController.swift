//
//  ProductManagementViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class ProductManagementViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "产品管理"
        
        self.navBarAddRightBarButton(title: "添加")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        let vc = AddProductViewController()
        self.push(vc)
    }

}
