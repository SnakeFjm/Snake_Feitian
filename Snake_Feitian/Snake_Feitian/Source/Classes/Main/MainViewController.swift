//
//  MainViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/6.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    var messageNav: BaseNavigationController!
    var workbenchNav: BaseNavigationController!
    var mineNav: BaseNavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建子控制器
        self.createSubviewControllers()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSubviewControllers() {
        
        let messageVC: MessageViewController = MessageViewController()
        messageNav = BaseNavigationController(rootViewController: messageVC)
        messageNav.tabBarItem = UITabBarItem.init(title: "我的消息", image: UIImage.init(named: "message") , selectedImage: UIImage.init(named: "message_selected"))
        
        let workbenchVC: WorkbenchViewController = WorkbenchViewController()
        workbenchNav = BaseNavigationController.init(rootViewController: workbenchVC)
        workbenchNav.tabBarItem = UITabBarItem.init(title: "工作台", image: UIImage.init(named: "workbench"), selectedImage: UIImage.init(named: "workbench_selected"))
        
        let mineVC: MineViewController = MineViewController()
        mineNav = BaseNavigationController.init(rootViewController: mineVC)
        mineNav.tabBarItem = UITabBarItem.init(title: "我的", image: UIImage.init(named: "mine"), selectedImage: UIImage.init(named: "mine_selected"))
        
        self.viewControllers = [messageNav,workbenchNav,mineNav]
        self.tabBar.barTintColor = UIColor.white

    }
    
}
