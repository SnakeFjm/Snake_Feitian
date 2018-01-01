//
//  MineCustomerViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class MineCustomerViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var MineCustomerTableView: UITableView!
    
    var dataList: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "我的客户"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "新增客户", style: .plain, target: self, action: #selector(addNewCustomer))
        
        self.MineCustomerTableView.register(UINib.init(nibName: "MineCustomerTableViewCell", bundle: nil), forCellReuseIdentifier: "MineCustomerTableViewCell")
        self.MineCustomerTableView.tableFooterView = UIView()
        
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
    
    func loadDataFromServer() {
        
        let userId: Int = SessionManager.share.userId
        let apiName: String = "http://123.207.68.190:21026/api/v1/customer/user/" + "\(userId)"
//        HttpRequestManager.sharedManager.getRequest(apiName: apiName, paramDict: [:]) { (isSuccess: Bool, resultObject: Any) in
//            
//            if isSuccess {
//                let array: NSArray = resultObject as! NSArray
//                self.dataList = NSMutableArray.init(array: array)
//                
//                self.MineCustomerTableView.reloadData()
//
//            }
//            
//        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    @objc func addNewCustomer() {
        let addNewCustomerVC: AddNewCustomerViewController = AddNewCustomerViewController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addNewCustomerVC, animated: true)
    }

    // =================================
    // MARK:
    // =================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MineCustomerTableViewCell = self.MineCustomerTableView.dequeueReusableCell(withIdentifier: "MineCustomerTableViewCell", for: indexPath) as! MineCustomerTableViewCell
        
        let dict: NSDictionary = self.dataList[indexPath.row] as! NSDictionary
        cell.updateUI(dict: dict)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict: NSDictionary = self.dataList[indexPath.row] as! NSDictionary
        let customerId: Int = dict.object(forKey: "id") as! Int
        
        let detailCustomerVC: DetailCustomerViewController = DetailCustomerViewController()
        detailCustomerVC.customerId = customerId
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailCustomerVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
 /*
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cancelAction: UITableViewRowAction = UITableViewRowAction.init(style: .destructive, title: "删除") { (_, _) in
            let branchId: Int = (self.dataList[indexPath.row] as! NSDictionary)["id"] as! Int
            let apiName: String = "http://123.207.68.190:21026/api/v1/branch/" + "\(branchId)"
            
            HttpRequestManager.sharedManager.deleteRequest(apiName: apiName, paramDict: [:], resultCallback: { (isSuccess: Bool, resultObject: Any) in
                
                if isSuccess {
                    self.loadDataFromServer()
                }
            })
        }
        
        let editAction: UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "修改") { (_, _) in
            
            //TODO
            let editVC: EditShopViewController = EditShopViewController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(editVC, animated: true)
            
        }
        
        return [cancelAction,editAction]
    }
    */
    

}
