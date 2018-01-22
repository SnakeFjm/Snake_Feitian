//
//  ShopManagementViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ShopManagementViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var shopTableView: UITableView!
    
    var shopManagementJson: [JSON] = []
    
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
    
    func loadDataFromServer() {
        
        let apiName: String = URLManager.Feitian_branch()
        let parameters: Parameters = ["userId": SessionManager.share.userModel.id]
        //
        HttpManager.shareManager.getRequest(apiName, parameters: parameters).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response: response) {
                //
                self.shopManagementJson = result.arrayValue
                //
                self.shopTableView.reloadData()
            }
        }
        
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
        return self.shopManagementJson.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShopManagementTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShopManagementTableViewCell", for: indexPath) as! ShopManagementTableViewCell
        
        let result = self.shopManagementJson[indexPath.row]
        cell.updateCellUI(result: result)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction: UITableViewRowAction = UITableViewRowAction.init(style: .destructive, title: "删除") { (_, _) in
            let branchId: Int = self.shopManagementJson[indexPath.row]["id"].intValue
            let apiName: String = URLManager.Feitian_branch(branchId: branchId)
            //
            HttpManager.shareManager.deleteRequest(apiName).responseJSON(completionHandler: { (response) in
                if let _ = HttpManager.parseDataResponse(response: response) {
                    self.loadDataFromServer()
                    tableView.deleteRows(at: [indexPath], with: .top)
                }
            })
        }
        
        let editAction: UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "修改") { (_, _) in
            
            //TODO
            let editVC: EditShopViewController = EditShopViewController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(editVC, animated: true)
            
        }
        
        return [deleteAction,editAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailShopVC: DetailShopViewController = DetailShopViewController()
        detailShopVC.branchId = self.shopManagementJson[indexPath.row]["id"].intValue
        //
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailShopVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
