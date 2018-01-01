//
//  ShopManagementViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class ShopManagementViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var shopTableView: UITableView!
    
    var dataList: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "店铺管理"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "新增店铺", style: .plain, target: self, action: #selector(addNewShop))
        
        self.shopTableView.register(UINib.init(nibName: "ShopManagementTableViewCell", bundle: nil), forCellReuseIdentifier: "ShopManagementTableViewCell")
        self.shopTableView.estimatedRowHeight = 80
        self.shopTableView.tableFooterView = UIView()
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.loadDataFromServer()
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func loadDataFromServer() {
        
        let apiName: String = "http://123.207.68.190:21026/api/v1/branch"
//        HttpRequestManager.sharedManager.getRequest(apiName: apiName, paramDict: [:]) { (isSuccess: Bool, resultObject: Any) in
//
//            if isSuccess {
//                let array: NSArray = resultObject as! NSArray
//                self.dataList = NSMutableArray.init(array: array)
//
//                self.shopTableView.reloadData()
//
//            }
//        }
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    @objc func addNewShop() {
        
        let addNewShopVC: AddNewShopViewController = AddNewShopViewController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addNewShopVC, animated: true)
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShopManagementTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShopManagementTableViewCell", for: indexPath) as! ShopManagementTableViewCell
        
        let dict: NSDictionary = self.dataList[indexPath.row] as! NSDictionary
        cell.updateUI(dict: dict)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cancelAction: UITableViewRowAction = UITableViewRowAction.init(style: .destructive, title: "删除") { (_, _) in
            let branchId: Int = (self.dataList[indexPath.row] as! NSDictionary)["id"] as! Int
            let apiName: String = "http://123.207.68.190:21026/api/v1/branch/" + "\(branchId)"
            
//            HttpRequestManager.sharedManager.deleteRequest(apiName: apiName, paramDict: [:], resultCallback: { (isSuccess: Bool, resultObject: Any) in
//
//                if isSuccess {
//                    self.loadDataFromServer()
//                }
//            })
            
        }
        
        let editAction: UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "修改") { (_, _) in
            
            //TODO
            let editVC: EditShopViewController = EditShopViewController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(editVC, animated: true)
            
        }
        
        return [cancelAction,editAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailShopVC: DetailShopViewController = DetailShopViewController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailShopVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
