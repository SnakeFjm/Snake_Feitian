//
//  MineViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/6.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mineTableView: UITableView!
    
    let dataList: [String] = ["关于我们", "退出登录"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的"
        
        self.setTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    func setTableView() {
        
        self.mineTableView.register(UINib.init(nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: "MineCell")
        self.mineTableView.tableFooterView = UIView.init()
        
        let headView = MineHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120))
        headView.updateUI(dict: [:])
        headView.iconNameLabel.text = String.init(SessionManager.share.userModel.name.last!)
        self.mineTableView.tableHeaderView = headView
        //
        self.mineTableView.tableHeaderView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(checkPersonalInfo)))
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MineTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MineCell", for: indexPath) as! MineTableViewCell
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "修改密码"
        } else {
            cell.textLabel?.text = self.dataList[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 修改密码
        if indexPath.section == 0 && indexPath.row == 0 {
            let alterVC: AlterPasswordViewController = AlterPasswordViewController()
            self.push(alterVC)
        }
        
        // 退出登录
        if indexPath.section == 1 && indexPath.row == 1 {
            //
            SessionManager.share.cleanBasicInformation()
            //
            SessionManager.share.isLogin = false
            //
            NotificationCenter.default.post(name: K_LOGIN_CHECK_STATUS, object: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    // =================================
    // MARK:
    // =================================
    
    // 查看个人信息
    @objc func checkPersonalInfo() {
        let infoVC = CheckPersonalInfoViewController()
        self.push(infoVC)
    }

}
