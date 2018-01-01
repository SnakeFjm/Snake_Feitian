//
//  EmployeesManagementViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class EmployeesManagementViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var EmployeesManagementTableView: UITableView!
    
    var dataList: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "员工管理"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "员工注册", style: .plain, target: self, action: #selector(addEmployees))

        self.EmployeesManagementTableView.register(UINib.init(nibName: "EmployeesManagementTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeesManagementTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.loadDataFromServer()
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func loadDataFromServer() {
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    @objc func addEmployees() {
    
    }
    
    // =================================
    // MARK:
    // =================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: EmployeesManagementTableViewCell = self.EmployeesManagementTableView.dequeueReusableCell(withIdentifier: "EmployeesManagementTableViewCell", for: indexPath) as! EmployeesManagementTableViewCell
        
        return cell
    }

}
