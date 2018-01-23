//
//  ChooseProductViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/23.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class ChooseProductViewController: ProductManagementViewController {

    var chooseProductCallback = {(productId: Int, productName: String) -> () in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.title = "选择产品"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        let productId = self.dataArray[indexPath.row]["id"].intValue
        let productName = self.dataArray[indexPath.row]["name"].stringValue
        self.chooseProductCallback(productId, productName)
        self.back()
    }

}
