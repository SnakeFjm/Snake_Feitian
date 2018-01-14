//
//  MineCustomerViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MineCustomerViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var MineCustomerTableView: UITableView!
    
    var customerModel: CustomerModel!
    
    var dataArray: [JSON] = []
    
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
        let apiName: String = URLManager.feitian_customerUser(userId: userId)
        
        //
        HttpManager.shareManager.getRequest(apiName).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response: response) {
                //
                self.dataArray = result.arrayValue
                
                //
                self.MineCustomerTableView.reloadData()
            }
        }

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
        return self.dataArray.count
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MineCustomerTableViewCell = self.MineCustomerTableView.dequeueReusableCell(withIdentifier: "MineCustomerTableViewCell", for: indexPath) as! MineCustomerTableViewCell
        //
        let result = self.dataArray[indexPath.row]
        cell.updateCellUI(result: result)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //
        let customerId: Int = self.dataArray[indexPath.row]["id"].intValue
        
        let detailCustomerVC: DetailCustomerViewController = DetailCustomerViewController()
        detailCustomerVC.customerId = customerId
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailCustomerVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
 
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let cancelAction: UITableViewRowAction = UITableViewRowAction.init(style: .destructive, title: "删除") { (_, _) in
//            let branchId: Int = self.dataArray[indexPath.row]["id"].intValue
//            let apiName: String = URLManager.Feitian_branch(branchId: branchId)
//                //"http://123.207.68.190:21026/api/v1/branch/" + "\(branchId)"
//
//            HttpManager.shareManager.deleteRequest(apiName).responseJSON(completionHandler: { (response) in
//                if let _ = HttpManager.parseDataResponse(response: response) {
//                    self.loadDataFromServer()
//                }
//            })
//
////            HttpRequestManager.sharedManager.deleteRequest(apiName: apiName, paramDict: [:], resultCallback: { (isSuccess: Bool, resultObject: Any) in
////
////                if isSuccess {
////                    self.loadDataFromServer()
////                }
////            })
//        }
//
//        let editAction: UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "修改") { (_, _) in
//
//            //TODO
//            let editVC: EditShopViewController = EditShopViewController()
//            self.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(editVC, animated: true)
//
//        }
//
//        return [cancelAction,editAction]
//    }
 
    

}
