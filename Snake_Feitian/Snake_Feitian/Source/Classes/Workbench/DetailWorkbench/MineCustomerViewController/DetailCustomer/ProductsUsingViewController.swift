//
//  ProductsUsingViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/14.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class ProductsUsingViewController: RefreshTableViewController {

    var customerModel: CustomerModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "在用产品"
        
        self.navBarAddRightBarButton(title: "添加")
        
        //
        self.registerCellNib(nibName: "BaseTitleDetailTableViewCell")
        self.tableView.separatorStyle = .singleLine
        self.tableView.tableFooterView = UIView.init()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadDataFromServer()
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func loadDataFromServer() {
        
        let customerId = self.customerModel.id
        let apiName = URLManager.feitian_productCustomer(customerId: customerId)
        
        HttpManager.shareManager.getRequest(apiName).responseJSON { (response) in
            if let resutl = HttpManager.parseDataResponse(response: response) {
                //
                self.dataArray = resutl.arrayValue
                
                self.reloadTableViewData()
            }
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BaseTitleDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BaseTitleDetailTableViewCell", for: indexPath) as! BaseTitleDetailTableViewCell

        cell.title.text = self.dataArray[indexPath.row].stringValue
        
        return cell
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func navBarRightBarButtonDidTouch(_ sender: Any) {
        let vc = addProductsUsingViewController()
        vc.customerModel = self.customerModel
        self.push(vc)
    }

}
